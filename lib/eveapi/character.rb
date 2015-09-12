module EVEApi
  # Character class
  class Character
    attr_accessor :name
    attr_accessor :character_id
    attr_accessor :corporation_name
    attr_accessor :corporation_id
    attr_accessor :alliance_id
    attr_accessor :alliance_name
    attr_accessor :faction_id
    attr_accessor :faction_name
    attr_accessor :key_id
    attr_accessor :vcode
    attr_accessor :client

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
      :contracts,
      :wallet_transactions,
      :wallet_journal,
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

    METHODS.each do |m|
      name = "char_#{m}".to_sym
      define_method(m) { client.send(name) }
    end
  end
end
