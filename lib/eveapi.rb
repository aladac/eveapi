lib_dir = File.dirname(__FILE__)
$LOAD_PATH << lib_dir unless $LOAD_PATH.include?(lib_dir)

require 'eveapi/version'
require 'eveapi/client'
require 'eveapi/request'
require 'eveapi/util'
require 'excon'
require 'crack'

include EVEApi::Util

# EVEApi namespace
module EVEApi
  API_ENDPOINT = 'https://api.eveonline.com'
  WORKING_METHODS = [
    :account_api_key_info,
    :account_account_status,
    :account_characters,
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
    :char_account_balance
  ]
end
