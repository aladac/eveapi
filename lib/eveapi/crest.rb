module EVEApi
  # CREST API handling
  class Crest
    attr_accessor :connection
    def initialize
      @connection ||= Excon.new(CREST_ENDPOINT)
    end

    def get_request(args)
      body = connection.get(path: args[:path], query: args[:query]).body
      Crack::JSON.parse body
    end

    def alliances
      output = convert_hash_keys(get_request(path: 'alliances/'))
      2.upto(output[:page_count]) do |i|
        http = get_request(path: 'alliances/', query: { page: i })
        new_request = convert_hash_keys(http)
        output[:items].concat(new_request[:items])
      end
      output[:items].map do |item|
        EVEApi::Alliance.new item.merge!(item[:href])
      end
    end
  end
end
