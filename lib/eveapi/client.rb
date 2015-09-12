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

    def api_methods_hash
      api_call_list[:calls].map do |m|
        { name: m.ruby_method_name, desc: m[:description] }
      end
    end

    def characters_array(account_characters)
      account_characters.to_a.map do |character|
        args = character
        args.merge!(key_id: key_id, vcode: vcode)
        Character.new(args)
      end
    end

    def characters_hash(account_characters)
      args = account_characters
      args.merge!(key_id: key_id, vcode: vcode)
      [Character.new(args)]
    end

    def characters
      case account_characters
      when Array
        return characters_array(account_characters)
      when Hash
        return characters_hash(account_characters)
      end
    end

    def server_status
      api_request(:server_server_status)
    end

    def account_status
      api_request(:account_account_status)
    end

    def key_info
      api_request(:account_api_key_info)
    end

    def call_list
      api_request(:api_call_list)
    end

    def api_request(name)
      http = connection.get(path: name.to_path, query: params)
      request = EVEApi::Request.new(http)
      request.result
    end

    def method_missing(name, *_args, &_block)
      fail 'Invalid Method Name' if name.to_path.empty?
      api_request(name)
    end

    def working_methods
      EVEApi::WORKING_METHODS
    end
  end
end
