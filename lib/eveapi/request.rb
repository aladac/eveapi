module EVEApi
  class Request
    attr_accessor :data
    attr_accessor :result
    attr_accessor :response

    def initialize(response=nil)
      @response = response
      @data = parse_xml
      @result = self.parse_result
      raise 'No such method' if response.status == 404
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
        {
          groups: data['eveapi']['result']['rowset'].first['row'],
          methods: data['eveapi']['result']['rowset'].last['row']
        }
      end
    end
  end
end
