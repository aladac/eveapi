lib_dir = File.dirname(__FILE__)
$LOAD_PATH << lib_dir unless $LOAD_PATH.include?(lib_dir)

require 'eveapi/version'
require 'eveapi/client'
require 'eveapi/request'
require 'excon'
require 'crack'

class String
  def camelize
    self.split("_").each {|s| s.capitalize! }.join("")
  end
  def underscore
    self.scan(/[A-Z][a-z]*/).join("_").downcase
  end
end

module EVEApi
  API_ENDPOINT = 'https://api.eveonline.com'
end
