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
        api_result = data['eveapi']['result']
        api_result['rowset']['row']
      rescue NoMethodError
        case api_result
        when Hash
          api_result.each_value do |v|
            v.process_rows if v.is_a?(Hash)
          end
        else
          api_result
        end
      rescue TypeError
        # api_result.process_rows
        api_result['rowset'].each do |r|
          r.process_rows if r.is_a?(Hash)
          api_result.merge!({ r['name'].underscore.to_sym => r['row'] })
        end
        api_result
      end
    end
  end
end
