module EVEApi
  # CREST API handling
  class Crest
    attr_accessor :connection
    def initialize
      @connection ||= Excon.new(CREST_ENDPOINT)
    end

    def paginate(path)
      output = json_get(CREST_ENDPOINT, path: path)
      2.upto(output[:page_count]) do |i|
        new_request = json_get(CREST_ENDPOINT, path: path, query: { page: i })
        output[:items].concat(new_request[:items])
      end
      output[:items]
    end
    private :paginate

    # List of Alliances
    #
    # @return [Array] +Array+ of {Alliance} objects
    # @see Alliance
    def alliances
      alliances = paginate(__method__.to_s + '/')
      alliances.map do |alliance|
        EVEApi::Alliance.new alliance[:href]
      end
    end

    # List of Types
    #
    # @return [Array] List of types with descriptions and ID's
    def types
      types = paginate(__method__.to_s + '/')
      types.map do |type|
        type.merge!(type_id: type[:href].match(%r{(\d*)\/$})[1])
      end
    end
  end
end
