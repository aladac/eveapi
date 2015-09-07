require 'simplecov'
SimpleCov.start
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require 'rspec'
require 'eveapi/version'

include EVEApi
