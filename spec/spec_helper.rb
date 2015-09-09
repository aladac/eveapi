unless ENV['CODECLIMATE_REPO_TOKEN']
  require 'simplecov'
  SimpleCov.start
end
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
require 'rspec'
require 'eveapi/version'
require 'vcr'

include EVEApi

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_hosts 'codeclimate.com'
end
