module EVEApi
  class Client
    attr_accessor :connection
    attr_accessor :key_id
    attr_accessor :vcode
    attr_accessor :character_id
    attr_accessor :row_count

    def initialize(key_id=nil, vcode=nil, character_id=nil)
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
      { 'rowCount' => row_count, 'keyID' => key_id, 'vCode' => vcode, 'characterID' => character_id }.select { |k,v| v }
    end

    def api_methods
      api_call_list[:calls].map { |m| ( m[:type][0..3].downcase + '_' + m[:name].underscore ).to_sym }
    end

    def method_missing(name, *args, &block)
      raise 'Invalid Method Name' if check_path(name).empty?
      check_path(name)
      request = EVEApi::Request.new @connection.get(path: check_path(name), query: params)
      request.result
    end
    def working_methods
      [
        :account_api_key_info,
        :account_account_status,
        :server_server_status,
        :char_contracts,
        :char_wallet_transactions,
        :char_wallet_journal,
        :char_upcoming_calendar_events,
        :char_standings,
        :char_skill_queue,
        :char_skill_in_training,
        :char_research,
        :char_notifications,
        :char_medals,
        :char_market_orders,
        :char_mail_messages,
        :char_mailing_lists,
        :char_industry_jobs,
        :char_contact_notifications,
        :char_contact_list,
        :char_character_sheet,
        :char_asset_list,
        :char_account_balance,
      ]
    end
  end
end
