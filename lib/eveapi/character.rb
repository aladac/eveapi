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

    def process_args(args = {})
      args.each_pair do |k, v|
        fail ArgumentError unless client.respond_to?(k)
        client.instance_variable_set("@#{k}".to_sym, v)
      end
    end
    private :process_args

    def send_client_method(m, args = {})
      process_args(args)
      client.send(client_method(m))
    end
    private :send_client_method

    METHODS.each do |m|
      define_method(m) { |args = {}| send_client_method(m, args) }
    end
  end
end
