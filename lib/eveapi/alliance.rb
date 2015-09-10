module EVEApi
  # Alliance CREST object
  class Alliance
    #     => {
    #           :href => "https://public-crest.eveonline.com/alliances/99000006/",
    #         :id_str => "99000006",
    #     :short_name => "666",
    #             :id => 99000006,
    #           :name => "Everto Rex Regis"
    # }
    BASE_URI = 'https://public-crest.eveonline.com/alliances/'

    attr_accessor :href
    attr_accessor :id_str
    attr_accessor :short_name
    attr_accessor :name
    attr_accessor :id
    attr_accessor :info

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

    def info
      @info ||= convert_hash_keys json_get(href)
    end

    def corporations
      info[:corporations]
    end

    def find
      @short_name = info[:short_name]
      @name = info[:name]
      self
    end

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
