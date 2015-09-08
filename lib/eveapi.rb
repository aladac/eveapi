lib_dir = File.dirname(__FILE__)
$LOAD_PATH << lib_dir unless $LOAD_PATH.include?(lib_dir)

require 'eveapi/version'
require 'eveapi/client'
require 'eveapi/request'
require 'eveapi/util'
require 'excon'
require 'crack'

include EVEApi::Util

class String
  def camelize
    self.split("_").each {|s| s.capitalize! }.join("")
  end

  # Stolen from ActiveSupport::Inflector
  def underscore
    return self unless self =~ /[A-Z-]|::/
    word = self.to_s.gsub(/::/, '/')
    word.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end
end

module EVEApi
  API_ENDPOINT = 'https://api.eveonline.com'
end
