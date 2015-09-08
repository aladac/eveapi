module EVEApi
  class Request
    attr_accessor :data
    attr_accessor :result
    attr_accessor :response

    def initialize(response=nil)
      @response = response
      raise 'No such method' if response.status == 404
      @data = parse_xml
      @result = convert_hash_keys(self.parse_result)
      raise error if error
    end

    def error
      data['eveapi'].has_key?('error') ? data['eveapi']['error'] : false
    end

    def parse_xml
      Crack::XML.parse(response.body)
    end

    def parse_result
      begin
        data['eveapi']['result']['rowset']['row']
      rescue NoMethodError
        case data['eveapi']['result']
        when Hash
          data['eveapi']['result']
          data['eveapi']['result'].each_value do |v|
            v.process_rows if v.is_a?(Hash)
          end
        else
          data['eveapi']['result']
        end
      rescue TypeError
        output = {}
        data['eveapi']['result']['rowset'].each do |r|
          output.merge!({ r['name'].underscore.to_sym => r['row'] })
        end
        output
      end
    end
  end
end
