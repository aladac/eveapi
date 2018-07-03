module EVEApi
  # Character class
  class Character
    attr_accessor :name             # @return [String] Character name
    attr_accessor :character_id     # @return [String] Character ID
    attr_accessor :corporation_name # @return [String] Corporation name
    attr_accessor :corporation_id   # @return [String] Corporation ID
    attr_accessor :alliance_id      # @return [String] Alliance ID
    attr_accessor :alliance_name    # @return [String] Alliance name
    attr_accessor :faction_id       # @return [String] Faction ID
    attr_accessor :faction_name     # @return [String] Faction name
    attr_accessor :key_id           # @return [String] API key ID
    attr_accessor :vcode            # @return [String] API key verification code
    attr_accessor :client           # @return [Client] {EVEApi::Client} instance

    def initialize(args = {})
      @key_id           = args[:key_id]
      @vcode            = args[:vcode]
      @name             = args[:name]
      @character_id     = args[:character_id]
      @corporation_name = args[:corporation_name]
      @corporation_id   = args[:corporation_id]
      @alliance_id      = args[:alliance_id]
      @alliance_name    = args[:alliance_name]
      @faction_id       = args[:faction_id]
      @faction_name     = args[:faction_name]
    end

    def client
      @client ||= Client.new(key_id, vcode, character_id)
    end

    # Wallet Journal
    #
    # @param [Hash] args +:row_count+
    # @return [Array] Wallet Journal
    # @example
    #   client.characters.last.wallet_journal.first
    #   # => {
    #   #                :date => "2015-09-12 21:28:29",
    #   #              :ref_id => "11650126182",
    #   #         :ref_type_id => "42",
    #   #         :owner_name1 => "Adrian Dent",
    #   #           :owner_id1 => "810699209",
    #   #         :owner_name2 => "",
    #   #           :owner_id2 => "0",
    #   #           :arg_name1 => "",
    #   #             :arg_id1 => "0",
    #   #              :amount => "-6099996.94",
    #   #             :balance => "14125001916.75",
    #   #              :reason => "",
    #   #     :tax_receiver_id => "",
    #   #          :tax_amount => "",
    #   #      :owner1_type_id => "2",
    #   #      :owner2_type_id => "1375"
    #   # }
    def wallet_journal(args = {})
      send_client_method(__method__, args)
    end

    # Skill queue
    #
    # @return [Array] Skill queue
    # @example
    #   character = client.characters.last
    #   character.skill_queue.first
    #   # => {
    #   #     :queue_position => "0",
    #   #            :type_id => "3412",
    #   #              :level => "5",
    #   #           :start_sp => "380844",
    #   #             :end_sp => "768000",
    #   #         :start_time => "2015-09-12 22:39:19",
    #   #           :end_time => "2015-09-21 02:11:28"
    #   # }
    def skill_queue(args = {})
      send_client_method(__method__, args)
    end

    # Character methods known to work
    METHODS = %i[
      contracts
      wallet_transactions
      upcoming_calendar_events
      standings
      skill_in_training
      research
      notifications
      medals
      market_orders
      mail_messages
      mailing_lists
      industry_jobs
      contact_notifications
      contact_list
      character_sheet
      asset_list
      account_balance
    ].freeze

    # Converts the {Character} method name to {Client} method name
    #
    # @param [Symbol] method_name +Character+ method name
    # @return [Symbol] {Client} method name
    def client_method(method_name)
      "char_#{method_name}".to_sym
    end
    private :client_method

    # Process arguments for Client method
    #
    # @param [Hash] args = {} Client method arguments
    def process_args(args = {})
      args.each_pair do |k, v|
        raise ArgumentError unless client.respond_to?(k)
        client.instance_variable_set("@#{k}".to_sym, v)
      end
    end
    private :process_args

    # Send a method to a {Client} instance
    #
    # @param [String] method_name Method name
    # @param [Hash] args = {} Method arguments
    def send_client_method(method_name, args = {})
      process_args(args)
      client.send(client_method(method_name))
    end
    private :send_client_method

    METHODS.each do |m|
      define_method(m) { |args = {}| send_client_method(m, args) }
    end
  end
end
