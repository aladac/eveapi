module EVEApi
  class Alliance
    #     => {
    #           :href => "https://public-crest.eveonline.com/alliances/99000006/",
    #         :id_str => "99000006",
    #     :short_name => "666",
    #             :id => 99000006,
    #           :name => "Everto Rex Regis"
    # }

    attr_accessor :href
    attr_accessor :id_str
    attr_accessor :short_name
    attr_accessor :name
    attr_accessor :id

    def initialize(args)
      @href = args[:href]
      @id_str = args[:id_str]
      @short_name = args[:short_name]
      @name = args[:name]
      @id = args[:id]
    end

    def info
      Crack::JSON.parse Excon.get(href).body
    end

    def corporations
      info['corporations']
    end

    def to_h
      h = Hash.new
      instance_variables.each do |var|
        name = var.to_s.gsub(/^@/,'').to_sym
        value = eval var.to_s
        h[name] = value
      end
      h
    end
  end
end
