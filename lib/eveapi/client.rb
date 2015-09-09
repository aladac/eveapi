module EVEApi
  # Client instance and HTTP method handling
  class Client
    attr_accessor :connection
    attr_accessor :key_id
    attr_accessor :vcode
    attr_accessor :character_id
    attr_accessor :row_count

    def initialize(key_id = nil, vcode = nil, character_id = nil)
      @connection ||= Excon.new(API_ENDPOINT)
      @key_id = key_id
      @character_id = character_id
      @vcode = vcode
    end

    def check_path(name)
      parts = name.to_s.split('_')
      return '' if parts.count < 2
      "/#{parts[0]}/#{parts[1..-1].join('_').camelize}.xml.aspx"
    end

    def params
      {
        'rowCount'    => row_count,
        'keyID'       => key_id,
        'vCode'       => vcode,
        'characterID' => character_id
      }.select { |_k, v| v }
    end

    def api_methods
      api_methods_hash.map { |m| m[:name] }
    end

    def ruby_method_name(m)
      (m[:type][0..3].downcase + '_' + m[:name].underscore).to_sym
    end

    def api_methods_hash
      api_call_list[:calls].map { |m| { name: ruby_method_name(m), desc: m[:description] } }
    end

    def method_missing(name, *_args, &_block)
      fail 'Invalid Method Name' if check_path(name).empty?
      check_path(name)
      request = EVEApi::Request.new @connection.get(path: check_path(name), query: params)
      request.result
    end

    def working_methods
      EVEApi::WORKING_METHODS
    end
  end
end
