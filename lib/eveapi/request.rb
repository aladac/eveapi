module EVEApi
  class Request
    attr_accessor :data
    attr_accessor :result
    attr_accessor :response

    def initialize(response=nil)
      @response = response
      raise 'No such method' if response.status == 404
      @data = parse_xml
      @result = self.parse_result
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
        data['eveapi']['result']
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
