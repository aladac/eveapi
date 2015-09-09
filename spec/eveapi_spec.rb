require 'spec_helper'
require 'eveapi'

describe EVEApi, :vcr do
  before :each do
    @client = Client.new
  end
  it 'there should be a connection class' do
    expect { @client }.not_to raise_error
  end

  it 'connection instance variable should be of class Excon::Connection' do
    expect(@client.connection).to be_a(Excon::Connection)
  end

  it 'check_path method should return an empty string when name contains of 1 part' do
    expect(@client.check_path('name')).to eq('')
  end

  it 'check_path method should return a path string when name contains of 2 or more parts' do
    expect(@client.check_path('name_name')).to be_a(String)
    expect(@client.check_path('name_name')).not_to be_empty
  end

  it 'params should return an empty hash when no param variables present' do
    expect(Client.new.params).to be_a(Hash)
    expect(Client.new.params).to be_empty
  end

  it 'calling a method present in the EVEApi should success' do
    expect { @client.server_server_status }.not_to raise_error
  end

  it 'calling a method not present in the EVEApi should fail' do
    expect { @client.some_bs_method }.to raise_error(RuntimeError)
  end

  it 'calling api_methods should return an Array of method symobls' do
    expect(@client.api_methods).to be_an(Array)
  end

  Client.new.working_methods.each do |m|
    before :each do
      @client.key_id = '4278167'
      @client.vcode = 'supersecretstuff'
      @client.character_id = '95512059'
    end
    it "calling api method #{m}" do
      expect { @client.send(m) }.not_to raise_error
    end
  end
end

describe EVEApi::Request, :vcr do
  it 'there should be a EVEApi::Response class' do
    expect { Request }.not_to raise_error
  end
end
