![EVEApi for ruby](https://github.com/aladac/eveapi/raw/master/doc/eveapi.png)

*EVE API for ruby*

[![Gem Version](https://badge.fury.io/rb/eveapi.svg)](http://badge.fury.io/rb/eveapi)
[![Build Status](https://secure.travis-ci.org/aladac/eveapi.svg?branch=master)](https://travis-ci.org/aladac/eveapi)
[![Code Climate](https://codeclimate.com/github/aladac/eveapi/badges/gpa.svg)](https://codeclimate.com/github/aladac/eveapi)
[![Test Coverage](https://codeclimate.com/github/aladac/eveapi/badges/coverage.svg)](https://codeclimate.com/github/aladac/eveapi/coverage)
[![Downloads](https://img.shields.io/gem/dt/eveapi.svg)](https://rubygems.org/gems/eveapi)
[![Latest Version Downloads](https://img.shields.io/gem/dtv/eveapi.svg)](https://rubygems.org/gems/eveapi)


## General

Working methods names can be listed by calling `EVEApi::Client#working_methods`.

## Working methods

Check out [rubydoc.info](http://www.rubydoc.info/github/aladac/eveapi) for the documentation.

#### Client
- `EVEApi::Client.new`
- `EVEApi::Client#characters`
- `EVEApi::Client#server_status`
- `EVEApi::Client#call_list`
- `EVEApi::Client#working_methods`
- `EVEApi::Client#account_status`
- `EVEApi::Client#key_info`

#### Character

- `EVEApi::Character#wallet_journal`
- `EVEApi::Character#contracts`
- `EVEApi::Character#wallet_transactions`
- `EVEApi::Character#upcoming_calendar_events`
- `EVEApi::Character#standings`
- `EVEApi::Character#skill_queue`
- `EVEApi::Character#skill_in_training`
- `EVEApi::Character#research`
- `EVEApi::Character#notifications`
- `EVEApi::Character#medals`
- `EVEApi::Character#market_orders`
- `EVEApi::Character#mail_messages`
- `EVEApi::Character#mailing_lists`
- `EVEApi::Character#industry_jobs`
- `EVEApi::Character#contact_notifications`
- `EVEApi::Character#contact_list`
- `EVEApi::Character#character_sheet`
- `EVEApi::Character#asset_list`
- `EVEApi::Character#account_balance`

#### Crest
- `EVEApi::Crest.new`
- `EVEApi::Crest#allainces`
- `EVEApi::Crest#types`

#### Alliance
- `EVEApi::Alliance.find(id = nil)`
- `EVEApi::Alliance#info`
- `EVEApi::Alliance#corporations`
- `EVEApi::Alliance#to_h`

## CREST
Rudimentary CREST support is added via the `EVEApi::Crest` class.
Working mehtods


```ruby
a = Crest.new.alliances.select { |a| a.name == "Goonswarm Federation" }.first
=> #<EVEApi::Alliance:0x007fd511c48248 ...>
a.to_h
=> {
          :href => "https://public-crest.eveonline.com/alliances/1354830081/",
        :id_str => "1354830081",
    :short_name => "CONDI",
          :name => "Goonswarm Federation",
            :id => 1354830081
}
a.info['url']
=> "http://www.goonfleet.com"
a.info.keys
=> [
    [ 0] "startDate",
    [ 1] "corporationsCount",
    [ 2] "description",
    [ 3] "executorCorporation",
    [ 4] "primeHour_str",
    [ 5] "primeHour",
    [ 6] "deleted",
    [ 7] "corporationsCount_str",
    [ 8] "creatorCorporation",
    [ 9] "url",
    [10] "id_str",
    [11] "creatorCharacter",
    [12] "capitalSystem",
    [13] "corporations",
    [14] "shortName",
    [15] "id",
    [16] "name"
]
```


## Description

EVE Online API Client for ruby

## Features

Uses [excon](https://github.com/excon/excon),  [crack](https://github.com/jnunemaker/crack), `method_missing` and a couple of rescue blocks to automate access to EVE Online API.
- returns results as `Hash` or `Array`
- raises exceptions with messages from the API itself
- converts ruby methods like `account_api_info` to an EVE Online API request like `GET /account/APIKeyInfo.xml.aspx` along with query params.

## Examples

### Getting Implant names for character
```ruby
require 'eveapi'
# initialize the client with key_id, vcode, character_id
client = Client.new(4278167, "supersecretstuff", 95512059)
# => #<EVEApi::Client:0x007fe349ad0d48 ... >
client.characters.first.character_sheet[:implants].map { |i| i[:type_name] }
# => [
#     [0] "Social Adaptation Chip - Basic",
#     [1] "Cybernetic Subprocessor - Standard",
#     [2] "Memory Augmentation - Standard",
#     [3] "Neural Boost - Standard",
#     [4] "Ocular Filter - Standard"
# ]
```

### Server status
```ruby
require 'eveapi'
client.server_status
# => {
#        :server_open => "True",
#     :online_players => "32500"
# }
```

### Showing accounts characters

```ruby
require 'eveapi'
client = EVEApi::Client.new
client.key_id = 4278167
client.vcode = "7QJg6p5BZNpDBp2FIz39dGwa7jnNaXAuYyLUVitlTQ3rY60VPBcaTpJVfYIkiW5l"
client.characters
# => {
#                 :name => "Quint Slade",
#         :character_id => "95512059",
#     :corporation_name => "Imperial Academy",
#       :corporation_id => "1000166",
#          :alliance_id => "0",
#        :alliance_name => "",
#           :faction_id => "0",
#         :faction_name => ""
# }
```

## Requirements
`excon` and `crack` automatically installed as dependencies during `gem install`, or `bundle install` in development.

## Install

    $ gem install eveapi

## Copyright

Copyright (c) 2015 Adam Ladachowski

See LICENSE.txt for details.
