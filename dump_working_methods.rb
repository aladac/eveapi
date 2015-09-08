#!/usr/bin/env ruby
require './lib/eveapi'

client = EVEApi::Client.new
client.key_id = "2139278"
client.vcode = "BLG8R4woo0iG9zCnSS6mXzjrjp68DQlQhUbI2TG3J9VBF5Q8XkvNjm4QvrMtEdDJ"
client.character_id = '810699209'

client.api_methods.each do |m|
  begin
  client.send m
  puts ":#{m.to_s},"
  rescue => e
    # puts "#{m.to_s} failed: #{e.message}"
  end
end
