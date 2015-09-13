module EVEApi
  # Character class
  class Character
    # @method foobar
    # @param

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

    # @private
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

    # @method wallet_journal
    # Wallet Journal in the form of an +Array+ of wallet records
    #
    # @param [Fixnum] row_count=nil Number of result rows to return,
    #   API default is +50+, maximum value is +2560+
    # @return [Array] List of wallet records
    # @see Client
    # @example
    #     character = client.characters.first
    #     character.wallet_journal.first
    #     # => {
    #     #                :date => "2015-09-12 21:28:29",
    #     #              :ref_id => "11650126182",
    #     #         :ref_type_id => "42",
    #     #         :owner_name1 => "Adrian Dent",
    #     #           :owner_id1 => "810699209",
    #     #         :owner_name2 => "",
    #     #           :owner_id2 => "0",
    #     #           :arg_name1 => "",
    #     #             :arg_id1 => "0",
    #     #              :amount => "-6099996.94",
    #     #             :balance => "14125001916.75",
    #     #              :reason => "",
    #     #     :tax_receiver_id => "",
    #     #          :tax_amount => "",
    #     #      :owner1_type_id => "2",
    #     #      :owner2_type_id => "1375"
    #     # }

    METHODS = [
      :wallet_journal,
      :contracts,
      :wallet_transactions,
      :upcoming_calendar_events,
      :standings,
      :skill_queue,
      :skill_in_training,
      :research,
      :notifications,
      :medals,
      :market_orders,
      :mail_messages,
      :mailing_lists,
      :industry_jobs,
      :contact_notifications,
      :contact_list,
      :character_sheet,
      :asset_list,
      :account_balance
    ]

    # Converts the {Character} method name to {Client} method name
    #
    # @param [Symbol] method_name +Character+ method name
    # @return [Symbol] {Client} method name
    def client_method(m)
      "char_#{m}".to_sym
    end
    private :client_method

    METHODS.each do |m|
      define_method(m) do |**args|
        args.each_pair do |k, v|
          fail ArgumentError unless client.respond_to?(k)
          client.instance_variable_set("@#{k}".to_sym, v)
        end
        client.send(client_method(m))
      end
    end
  end
end
