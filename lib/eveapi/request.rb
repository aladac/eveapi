module EVEApi
  # Handling of requests and response from the EVE Online API
  class Request
    attr_accessor :data
    attr_accessor :result
    attr_accessor :response

    def initialize(response = nil)
      @response = response
      fail "HTTP: #{response.status}" unless response.status == 200
      @data = parse_xml
      @result = convert_hash_keys(parse_result)
      fail error if error
    end

    def error
      data['eveapi'].key?('error') ? data['eveapi']['error'] : false
    end
    private :error

    def parse_xml
      Crack::XML.parse(response.body)
    end
    private :parse_xml

    def process_hash(data)
      data.each_value do |v|
        v.process_rows if v.is_a?(Hash)
      end.process_rows
    end
    private :process_hash

    def process_array(data)
      data.each do |v|
        v.process_rows if v.is_a?(Hash)
      end
    end
    private :process_array

    def parse_result
      api_result = data['eveapi']['result']
      case api_result['rowset']['row']
      when Array
        return process_array api_result['rowset']['row']
      else
        return api_result['rowset']['row']
      end
    rescue TypeError, NoMethodError
      return process_hash(api_result)
    end
    private :parse_result
  end
end
