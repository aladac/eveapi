begin
  require 'eveapi/version'
rescue LoadError
end
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
      api_call_list[:methods].map { |m| m['type'][0..3].downcase + '_' + m['name'].underscore }
    end

    def method_missing(name, *args, &block)
      raise 'Invalid Method Name' if check_path(name).empty?
      check_path(name)
      response = @connection.get(path: check_path(name), query: params)
      raise 'No such method' if response.status == 404
      data = Crack::XML.parse(response.body)
      error = data['eveapi']['error']
      raise error if error
      begin
        data['eveapi']['result']['rowset']['row']
      rescue NoMethodError
        data['eveapi']['result']
      rescue TypeError
        {
          groups: data['eveapi']['result']['rowset'].first['row'],
          methods: data['eveapi']['result']['rowset'].last['row']
        }
      end
    end
  end
end
