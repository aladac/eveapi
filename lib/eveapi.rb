lib_dir = File.dirname(__FILE__)
$LOAD_PATH << lib_dir unless $LOAD_PATH.include?(lib_dir)

# EVEApi namespace
module EVEApi
  # CREST API endpoint
  CREST_ENDPOINT = 'https://public-crest.eveonline.com/'.freeze
  # v2 API endpoint
  API_ENDPOINT = 'https://api.eveonline.com'.freeze
  # Client methods implemented
  WORKING_METHODS = %i[
    account_status
    server_status
    characters
    api_methods
    key_info
    call_list
  ].freeze
end

require 'eveapi/version'
require 'eveapi/client'
require 'eveapi/request'
require 'eveapi/crest'
require 'eveapi/util'
require 'eveapi/alliance'
require 'eveapi/character'
require 'excon'
require 'crack'

include EVEApi::Util
