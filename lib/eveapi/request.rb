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

    def process_hash(data)
      data.each_value do |v|
        v.process_rows if v.is_a?(Hash)
      end.process_rows
    end

    def parse_result
      api_result = data['eveapi']['result']
      return api_result['rowset']['row']
    rescue TypeError, NoMethodError
      return process_hash(api_result)
    end
  end
end
