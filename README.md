# DEPRECATED!
see: [https://developers.eveonline.com/blog/article/a-eulogy-for-xml-crest](https://developers.eveonline.com/blog/article/a-eulogy-for-xml-crest)


![EVEApi for ruby](https://github.com/aladac/eveapi/raw/master/doc/eveapi.png)

[![Gem Version](https://badge.fury.io/rb/eveapi.svg)](http://badge.fury.io/rb/eveapi)
[![Build Status](https://secure.travis-ci.org/aladac/eveapi.svg?branch=master)](https://travis-ci.org/aladac/eveapi)
[![Code Climate](https://codeclimate.com/github/aladac/eveapi/badges/gpa.svg)](https://codeclimate.com/github/aladac/eveapi)
[![Test Coverage](https://codeclimate.com/github/aladac/eveapi/badges/coverage.svg)](https://codeclimate.com/github/aladac/eveapi/coverage)

## TOC
- [Description](#desc)
- [Documentation](#doc)
- [Install](#install)
- [Working methods](#methods)
  - [`Client`](#client)
  - [`Character`](#character)
  - [`Alliance`](#alliance)
  - [`Crest`](#crest_methods)
- [CREST](#crest)
- [Features](#feats)
- [Examples](#examples)
- [Requirements](#reqs)
- [Contributing](https://github.com/aladac/eveapi/blob/master/CONTRIBUTING.md)

<a name="name"></a>
## Description
EVE Online API Client for ruby

<a name="doc"></a>
## Documentation
- [rubydoc.info](http://rdoc.info/gems/eveapi)
- [legacy methods (wiki)](https://github.com/aladac/eveapi/wiki)

<a name="install"></a>
## Install
    $ gem install eveapi

<a name="methods"></a>
## Working methods
Working `Client` methods names can be listed by calling `EVEApi::Client#working_methods`.

Check out [rubydoc.info](http://rdoc.info/gems/eveapi) for the documentation.

*Legacy methods are available [here](https://github.com/aladac/eveapi/wiki)*

<a name="client"></a>
#### Client

- [`EVEApi::Client.new`](http://www.rubydoc.info/gems/eveapi/EVEApi/Client)
- [`EVEApi::Client#characters`](http://www.rubydoc.info/gems/eveapi/EVEApi/Client#characters-instance_method)
- [`EVEApi::Client#server_status`](http://www.rubydoc.info/gems/eveapi/EVEApi/Client#server_status-instance_method)
- [`EVEApi::Client#call_list`](http://www.rubydoc.info/gems/eveapi/EVEApi/Client#call_list-instance_method)
- [`EVEApi::Client#working_methods`](http://www.rubydoc.info/gems/eveapi/EVEApi/Client#working_methods-instance_method)
- [`EVEApi::Client#account_status`](http://www.rubydoc.info/gems/eveapi/EVEApi/Client#account_status-instance_method)
- [`EVEApi::Client#key_info`](http://www.rubydoc.info/gems/eveapi/EVEApi/Client#key_info-instance_method)

<a name="characters"></a>
#### Character

- [`EVEApi::Character#wallet_journal`](http://www.rubydoc.info/gems/eveapi/EVEApi/Character#wallet_journal-instance_method)
- [`EVEApi::Character#contracts`](http://www.rubydoc.info/gems/eveapi/EVEApi/Character#contracts-instance_method)
- [`EVEApi::Character#wallet_transactions`](http://www.rubydoc.info/gems/eveapi/EVEApi/Character#wallet_transactions-instance_method)
- [`EVEApi::Character#upcoming_calendar_events`](http://www.rubydoc.info/gems/eveapi/EVEApi/Character#upcoming_calendar_events-instance_method)
- [`EVEApi::Character#standings`](http://www.rubydoc.info/gems/eveapi/EVEApi/Character#standings-instance_method)
- [`EVEApi::Character#skill_queue`](http://www.rubydoc.info/gems/eveapi/EVEApi/Character#wallet_journal-instance_method)
- [`EVEApi::Character#skill_in_training`](http://www.rubydoc.info/gems/eveapi/EVEApi/Character#skill_in_training-instance_method)
- [`EVEApi::Character#research`](http://www.rubydoc.info/gems/eveapi/EVEApi/Character#research-instance_method)
- [`EVEApi::Character#notifications`](http://www.rubydoc.info/gems/eveapi/EVEApi/Character#notifications-instance_method)
- [`EVEApi::Character#medals`](http://www.rubydoc.info/gems/eveapi/EVEApi/Character#medals-instance_method)
- [`EVEApi::Character#market_orders`](http://www.rubydoc.info/gems/eveapi/EVEApi/Character#market_orders-instance_method)
- [`EVEApi::Character#mail_messages`](http://www.rubydoc.info/gems/eveapi/EVEApi/Character#mail_messages-instance_method)
- [`EVEApi::Character#mailing_lists`](http://www.rubydoc.info/gems/eveapi/EVEApi/Character#mailing_lists-instance_method)
- [`EVEApi::Character#industry_jobs`](http://www.rubydoc.info/gems/eveapi/EVEApi/Character#industry_jobs-instance_method)
- [`EVEApi::Character#contact_notifications`](http://www.rubydoc.info/gems/eveapi/EVEApi/Character#contact_notifications-instance_method)
- [`EVEApi::Character#contact_list`](http://www.rubydoc.info/gems/eveapi/EVEApi/Character#contact_list-instance_method)
- [`EVEApi::Character#character_sheet`](http://www.rubydoc.info/gems/eveapi/EVEApi/Character#character_sheet-instance_method)
- [`EVEApi::Character#asset_list`](http://www.rubydoc.info/gems/eveapi/EVEApi/Character#asset_list-instance_method)
- [`EVEApi::Character#account_balance`](http://www.rubydoc.info/gems/eveapi/EVEApi/Character#account_balance-instance_method)

<a name="crest_methods"></a>
#### Crest

- [`EVEApi::Crest.new`](http://www.rubydoc.info/gems/eveapi/EVEApi/Crest)
- [`EVEApi::Crest#alliances`](http://www.rubydoc.info/gems/eveapi/EVEApi/Crest#alliances-instance_method)
- [`EVEApi::Crest#types`](http://www.rubydoc.info/gems/eveapi/EVEApi/Crest#types-instance_method)

<a name="alliance"></a>
#### Alliance

- [`EVEApi::Alliance.find(id = nil)`](http://www.rubydoc.info/gems/eveapi/EVEApi/Alliance#find-instance_method)
- [`EVEApi::Alliance#info`](http://www.rubydoc.info/gems/eveapi/EVEApi/Alliance#info-instance_method)
- [`EVEApi::Alliance#corporations`](http://www.rubydoc.info/gems/eveapi/EVEApi/Alliance#corporations-instance_method)
- [`EVEApi::Alliance#to_h`](http://www.rubydoc.info/gems/eveapi/EVEApi/Alliance#to_h-instance_method)

<a name="crest"></a>
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

<a name="feats"></a>
## Features

Uses [excon](https://github.com/excon/excon),  [crack](https://github.com/jnunemaker/crack), `method_missing` and a couple of rescue blocks to automate access to EVE Online API.
- returns results as `Hash` or `Array`
- raises exceptions with messages from the API itself
- converts ruby methods like `account_api_info` to an EVE Online API request like `GET /account/APIKeyInfo.xml.aspx` along with query params.

<a name="examples"></a>
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
<a name="reqs"></a>
`excon` and `crack` automatically installed as dependencies during `gem install`, or `bundle install` in development.

## Copyright

Copyright (c) 2015 Adam Ladachowski

See [LICENSE.txt](https://github.com/aladac/eveapi/blob/master/LICENSE.txt) for details.
