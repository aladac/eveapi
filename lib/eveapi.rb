lib_dir = File.dirname(__FILE__)
$LOAD_PATH << lib_dir unless $LOAD_PATH.include?(lib_dir)

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

# EVEApi namespace
module EVEApi
  CREST_ENDPOINT = 'https://public-crest.eveonline.com/'
  API_ENDPOINT = 'https://api.eveonline.com'
  WORKING_METHODS = [
    :account_status,
    :server_status,
    :characters,
    :api_methods,
    :key_info,
    :call_list
  ]
end
