require 'spec_helper'
require 'eveapi'

describe EVEApi, :vcr do
  describe Client do
    let!(:client) { Client.new }

    it 'expect Client.new to succeed' do
      expect { client }.not_to raise_error
    end

    it 'expect Client#connection to be an Excon::Connection' do
      expect(client.connection).to be_a(Excon::Connection)
    end

    it 'expect check_path to return an empty String for a one part name' do
      expect(client.check_path('name')).to eq('')
    end

    it 'expect check_path to return a non-empty String for a muti-part name' do
      expect(client.check_path('name_name')).to be_a(String)
      expect(client.check_path('name_name')).not_to be_empty
    end

    it 'expect Client#params to return an empty hash when on no param' do
      expect(Client.new.params).to be_a(Hash)
      expect(Client.new.params).to be_empty
    end

    it 'expect calling an existing API method to succeed' do
      expect { client.server_server_status }.not_to raise_error
    end

    it 'expect calling a non-existing API method to fail' do
      expect { client.some_bs_method }.to raise_error(RuntimeError)
    end

    it 'expect api_methods to return an Array of method symobls' do
      expect(client.api_methods).to be_an(Array)
    end

    Client.new.working_methods.each do |m|
      let(:client) { Client.new }
      it "calling api method #{m}" do
        client.key_id = '4278167'
        client.vcode = 'supersecretstuff'
        client.character_id = '95512059'
        expect { client.send(m) }.not_to raise_error
      end
    end
  end

  describe Request do
    it 'there should be a EVEApi::Request class' do
      expect { Request }.not_to raise_error
    end
  end

  describe Crest do
    let!(:crest) { Crest.new }

    it 'expect Crest.new to succeed' do
      expect { crest }.not_to raise_error
    end

    it 'expect Crest#alliances to be an Array' do
      expect(crest.alliances).to be_an(Array)
    end
  end

  describe Alliance do
    let(:alliance) { Crest.new.alliances.first }

    it 'expect Alliance#info to be a Hash' do
      expect { alliance.info }.not_to raise_error
      expect(alliance.info).to be_a(Hash)
    end

    it 'expect Alliance#corporations to be an Array' do
      expect(alliance.corporations).to be_an(Array)
    end

    it 'expect Alliance#to_h to be a Hash' do
      expect(alliance.to_h).to be_a(Hash)
    end

    it 'expect Alliance.new with id argument to create an Alliance' do
      expect(Alliance.new('1354830081')).to be_an(Alliance)
    end

    it 'expect Alliance#find to fill short_name and name values' do
      alliance = Alliance.new('1354830081').find
      expect(alliance.short_name).to be_a(String)
      expect(alliance.short_name).not_to be_empty
      expect(alliance.name).to be_a(String)
      expect(alliance.name).not_to be_empty
    end
  end
end
