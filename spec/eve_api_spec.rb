require 'spec_helper'
require 'eveapi'

describe EVEApi, :vcr do
  let!(:client) { Client.new }
  let!(:client_auth) { Client.new('4278167', 'supersecretstuff', '95512059') }
  let!(:client_auth_two_chars) { Client.new('4669404', 'hushhush') }
  let!(:mutliple_characters) { client_auth_two_chars.characters }
  let!(:characters) { client_auth.characters }

  describe Client do
    it 'expect Client.new to succeed' do
      expect { client }.not_to raise_error
    end

    it 'expect Client#connection to be an Excon::Connection' do
      expect(client.connection).to be_a(Excon::Connection)
    end

    it 'expect Symbol#to_path to return an empty String for a one part name' do
      expect(:name.to_path).to eq('')
    end

    it 'expect Symbol#to_path to return a String for a muti-part name' do
      expect(:name_name.to_path).to be_a(String)
      expect(:name_name.to_path).not_to be_empty
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

    it 'expect Client#charcaters to succeed' do
      expect(characters).to be_an(Array)
    end

    it 'expect Client#characters to handle mutiple characters differently' do
      expect(mutliple_characters).to be_an(Array)
    end

    Client.new.working_methods.each do |m|
      it "calling api method #{m}" do
        expect { client_auth.send(m) }.not_to raise_error
      end
    end
  end

  describe Request do
    it 'expect there to be a EVEApi::Request class' do
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

    it 'expect Crest#types to be an Array' do
      expect(crest.types).to be_an(Array)
    end

    it 'expect details to return Hash when called on Hash with :href key' do
      expect(crest.types.first.details).to be_a(Hash)
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

  describe Character do
    let(:character) { mutliple_characters.last }
    it 'expect Character.new(args) to create a Character' do
      expect(character).to be_a(Character)
    end
    it 'expect a Character#account_balance to return a Hash' do
      expect(character.account_balance).to be_a(Hash)
    end
    it 'sets Client instance variable if method argument key matches name' do
      expect { character.wallet_journal(row_count: 1) }.not_to raise_error
    end
    it 'raises ArgumentError on non-existing instance variable' do
      expect { character.wallet_journal(a: 1) }.to raise_error(ArgumentError)
    end
    it 'expect Character#skill_queue to return an Array' do
      expect(character.skill_queue).to be_an(Array)
    end
  end
end
