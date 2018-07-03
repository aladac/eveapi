module EVEApi
  # Client instance and HTTP method handling
  class Client
    # HTTP connection to the API endpoint
    # @return [Excon::Connection]
    attr_accessor :connection
    # API Key ID
    # @return [String]
    attr_accessor :key_id
    # API Key verification code
    # @return [String]
    attr_accessor :vcode
    # Character ID
    # @return [String]
    attr_accessor :character_id
    # Number of result rows to get
    # @return [String]
    attr_accessor :row_count

    # @param [String] key_id API key ID
    # @param [String] vcode API verification code
    # @param [String] character_id Character ID
    # @return [EVEAPI::Client] client
    def initialize(key_id = nil, vcode = nil, character_id = nil)
      @connection ||= Excon.new(API_ENDPOINT)
      @key_id = key_id
      @character_id = character_id
      @vcode = vcode
    end

    # Query params used in the API request
    #
    # @return [Hash] query params for the API request
    def params
      {
        'rowCount'    => row_count,
        'keyID'       => key_id,
        'vCode'       => vcode,
        'characterID' => character_id
      }.select { |_k, v| v }
    end

    # API methods
    #
    # @return [Array] list of ruby API method names
    # @example
    #   client.api_methods
    #   # => [
    #   # [ 0] :char_chat_channels,
    #   # [ 1] :char_bookmarks,
    #   # [ 2] :char_locations,
    #   # [ 3] :char_contracts,
    #   # ...
    #   # ]
    def api_methods
      api_methods_hash.map { |m| m[:name] }
    end

    def api_methods_hash
      api_call_list[:calls].map do |m|
        { name: m.ruby_method_name, desc: m[:description] }
      end
    end
    private :api_methods_hash

    def characters_array(account_characters)
      account_characters.to_a.map do |character|
        args = character
        args[:key_id] = key_id
        args[:vcode] = vcode
        Character.new(args)
      end
    end
    private :characters_array

    def characters_hash(account_characters)
      args = account_characters
      args[:key_id] = key_id
      args[:vcode] = vcode
      [Character.new(args)]
    end
    private :characters_hash

    # List of characters belonging to the account
    #
    # @return [Array] of characters for account
    # @see Character
    # @example
    #   client = Client.new(4278167, "supersecretstuff", 95512059)
    #   characters = client.characters
    #   characters.first.name
    #   # => "Quint Slade"
    def characters
      case account_characters
      when Array
        characters_array(account_characters)
      when Hash
        characters_hash(account_characters)
      end
    end

    # Status of the Tranquility server
    #
    # @return [Hash] Tranquility server status
    # @example
    #   Client.new.server_status
    #   # => {
    #   #        :server_open => "True",
    #   #     :online_players => "25292"
    #   # }
    def server_status
      api_request(:server_server_status)
    end

    # Account Status
    #
    # @return [Hash] account status
    # @example
    #   client.account_status
    #   # => {
    #   #                   :paid_until => "2015-10-12 23:55:48",
    #   #                  :create_date => "2006-09-10 02:17:00",
    #   #                  :logon_count => "2276",
    #   #                :logon_minutes => "193996",
    #   #     :multi_character_training => nil,
    #   #                       :offers => nil
    #   # }
    def account_status
      api_request(:account_account_status)
    end

    # API key details
    #
    # @return [Hash] API key info
    # @example
    #    client = Client.new(4278167, "supersecretstuff", 95512059)
    #    client.key_info
    #    # => {
    #    #     :access_mask => "268435455",
    #    #            :type => "Account",
    #    #         :expires => "",
    #    #      :characters => {
    #    #             :character_id => "95512059",
    #    #           :character_name => "Quint Slade",
    #    #           :corporation_id => "1000166",
    #    #         :corporation_name => "Imperial Academy",
    #    #              :alliance_id => "0",
    #    #            :alliance_name => "",
    #    #               :faction_id => "0",
    #    #             :faction_name => ""
    #    #     }
    #    # }
    def key_info
      api_request(:account_api_key_info)
    end

    # Description of method
    # Details
    # @return [Hash] list of API +:calls+ and +:call_groups+
    # @example
    #   Client.new.call_list.keys
    #   # => [
    #   #     [0] :call_groups,
    #   #     [1] :calls
    #   #    ]
    #   Client.new.call_list[:call_groups]
    #   # => [
    #   # [0] {
    #   #    :group_id => "1",
    #   #        :name => "Account and Market",
    #   # :description => "Market Orders, account balance and journal history."
    #   # },
    #   # ... ]
    def call_list
      api_request(:api_call_list)
    end

    def api_request(name)
      http = connection.get(path: name.to_path, query: params)
      request = EVEApi::Request.new(http)
      request.result
    end
    private :api_request

    # Dynamic handling of API requests
    def method_missing(name, *_args, &_block)
      raise 'Invalid Method Name' if name.to_path.empty?
      api_request(name)
    end
    private :method_missing

    # List of implemented methods
    #
    # @return [Array] list of implemented +Client+ methods
    # @example
    #   Client.new.working_methods
    #   # => [
    #   #     [0] :account_status,
    #   #     [1] :server_status,
    #   #     [2] :characters,
    #   #     [3] :api_methods,
    #   #     [4] :key_info,
    #   #     [5] :call_list
    #   # ]
    def working_methods
      EVEApi::WORKING_METHODS
    end
  end
end
