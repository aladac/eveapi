require 'spec_helper'
require 'eveapi'

describe EVEApi do
  it "there should be a connection class" do
    expect { EVEApi::Client.new }.not_to raise_error
  end

  it "connection instance variable should be of class Excon::Connection" do
    expect(EVEApi::Client.new.connection).to be_a(Excon::Connection)
  end

  it "check_path method should return an empty string when name contains of 1 part" do
    expect(EVEApi::Client.new.check_path('name')).to eq('')
  end

  it "check_path method should return a path string when name contains of 2 or more parts" do
    expect(EVEApi::Client.new.check_path('name_name')).to be_a(String)
    expect(EVEApi::Client.new.check_path('name_name')).not_to be_empty
  end

  it "params should return an empty hash when no param variables present" do
    expect(EVEApi::Client.new.params).to be_a(Hash)
    expect(EVEApi::Client.new.params).to be_empty
  end

  it "calling a method present in the EVEApi should success" do
    expect { EVEApi::Client.new.server_server_status }.not_to raise_error
  end

  it "calling a method not present in the EVEApi should fail" do
    expect { EVEApi::Client.new.some_bs_method }.to raise_error(RuntimeError)
  end

  it "calling api_methods should return an Array of method symobls" do
    expect(EVEApi::Client.new.api_methods).to be_an(Array)
  end

  EVEApi::Client.new.working_methods.each do |m|
    before :each do
      @client = EVEApi::Client.new
      @client.key_id = "2139278"
      @client.vcode = "BLG8R4woo0iG9zCnSS6mXzjrjp68DQlQhUbI2TG3J9VBF5Q8XkvNjm4QvrMtEdDJ"
      @client.character_id = '810699209'
    end
    it "calling api method #{m}" do
      expect { @client.send(m) }.not_to raise_error
    end
  end
end

describe EVEApi::Request do
  it 'there should be a EVEApi::Response class' do
    expect { EVEApi::Request }.not_to raise_error
  end
end
