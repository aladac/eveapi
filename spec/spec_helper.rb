unless ENV['CODECLIMATE_REPO_TOKEN']
  require 'simplecov'
  SimpleCov.start
end
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require 'rspec'
require 'eveapi/version'

include EVEApi
