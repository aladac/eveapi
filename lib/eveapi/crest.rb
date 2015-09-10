module EVEApi
  # CREST API handling
  class Crest
    attr_accessor :connection
    def initialize
      @connection ||= Excon.new(CREST_ENDPOINT)
    end

    def get_request(args)
      Crack::JSON.parse connection.get(path: args[:path], query: args[:query]).body
    end

    def alliances
      output = convert_hash_keys(get_request(path: 'alliances/'))
      2.upto(output[:page_count]) do |i|
        new_request = convert_hash_keys(get_request(path: 'alliances/', query: { page: i }))
        output[:items].concat(new_request[:items])
      end
      output[:items].map { |item| EVEApi::Alliance.new item.merge!(item[:href]) }
    end
  end
end
