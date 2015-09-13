module EVEApi
  # Alliance CREST object
  class Alliance
    # CREST alliances endpoint
    BASE_URI = CREST_ENDPOINT + 'alliances/'

    attr_accessor :href       # @return [String] href
    attr_accessor :id_str     # @return [String] String ID
    attr_accessor :short_name # @return [String] Short name
    attr_accessor :name       # @return [String] Name
    attr_accessor :id         # @return [Fixnum] ID
    attr_accessor :info       # @return [Hash] Info

    def initialize(args)
      case args
      when String, Fixnum
        @id = args.to_i
        @href = BASE_URI + id.to_s + '/'
      when Hash
        @href = args[:href]
        @short_name = args[:short_name]
        @name = args[:name]
        @id = args[:id]
      end
    end

    # Get detailed Alliance info from CREST
    #
    # @return [Hash] Alliance info
    def info
      @info ||= json_get(href)
    end

    # Show corporations belonging to the Alliance
    #
    # @return [Array] List of corporations
    def corporations
      info[:corporations]
    end

    # Get Alliance from CREST by ID
    #
    # @return [Alliance] Alliance object
    def find
      @short_name = info[:short_name]
      @name = info[:name]
      self
    end

    # Converts {Alliance} to {Hash}
    #
    # @return [Hash] Alliance in {Hash} format
    def to_h
      h = {}
      instance_variables.each do |var|
        name = var.to_s.gsub(/^@/, '').to_sym
        value = send name
        h[name] = value
      end
      h
    end
  end
end
