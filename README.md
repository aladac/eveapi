![EVEApi for ruby](https://github.com/aladac/eveapi/raw/master/doc/eveapi.png)

*EVE API for ruby*

[![Gem Version](https://badge.fury.io/rb/eveapi.svg)](http://badge.fury.io/rb/eveapi)
[![Build Status](https://secure.travis-ci.org/aladac/eveapi.svg?branch=master)](https://travis-ci.org/aladac/eveapi)
[![Code Climate](https://codeclimate.com/github/aladac/eveapi/badges/gpa.svg)](https://codeclimate.com/github/aladac/eveapi)
[![Test Coverage](https://codeclimate.com/github/aladac/eveapi/badges/coverage.svg)](https://codeclimate.com/github/aladac/eveapi/coverage)
[![Downloads](https://img.shields.io/gem/dt/eveapi.svg)](https://rubygems.org/gems/eveapi)
[![Latest Version Downloads](https://img.shields.io/gem/dtv/eveapi.svg)](https://rubygems.org/gems/eveapi)


## Disclaimer!
*This work in progress in a very early stage. Not documented. Only a couple of methods are tested.*

~~Most~~ working methods names can be listed by calling ~~`EVEApi::Client#api_methods`~~ `EVEApi::Client#working_methods`

Because of the way the paths are being built from the method names - some methods may look funky eq. `server_server_status`.

## Auto Methods
These methods are procedurally handled.

```ruby
def method_missing(name, *_args, &_block)
  fail 'Invalid Method Name' if check_path(name).empty?
  check_path(name)
  http = connection.get(path: check_path(name), query: params)
  request = EVEApi::Request.new(http)
  request.result
end
```

The ones listed below are known to work, provided the instance variables listed in the *Requires* column are supplied.

| Method Name   | Requires      |  Output Class             |
| ------------- | ------------- | ------------- |
| [account_api_key_info](https://github.com/aladac/eveapi/wiki/account_api_key_info) |  `key_id`, `vcode`  | `Hash` |
| [account_account_status](https://github.com/aladac/eveapi/wiki/account_account_status) | `key_id`, `vcode` | `Hash` |
| [account_characters](https://github.com/aladac/eveapi/wiki/account_characters) | `key_id`, `vcode` | `Array` |
| [server_server_status](https://github.com/aladac/eveapi/wiki/server_server_status) | - | `Hash` |
| [char_wallet_transactions](https://github.com/aladac/eveapi/wiki/char_wallet_transactions) | `key_id`, `vcode`, `character_id` | `Array` |
| [char_wallet_journal](https://github.com/aladac/eveapi/wiki/char_wallet_journal) | `key_id`, `vcode`, `character_id` | `Array` |
| [char_standings](https://github.com/aladac/eveapi/wiki/char_standings) | `key_id`, `vcode`, `character_id` | `Array` |
| [char_skill_queue](https://github.com/aladac/eveapi/wiki/char_skill_queue) | `key_id`, `vcode`, `character_id` | `Array` |
| [char_skill_in_training](https://github.com/aladac/eveapi/wiki/char_skill_in_training) | `key_id`, `vcode`, `character_id` | `Hash` |
| [char_research](https://github.com/aladac/eveapi/wiki/char_research) | `key_id`, `vcode`, `character_id` | `Array` |
| [char_notifications](https://github.com/aladac/eveapi/wiki/char_notifications) | `key_id`, `vcode`, `character_id` | `Array` |
| [char_medals](https://github.com/aladac/eveapi/wiki/char_medals) |  `key_id`, `vcode`, `character_id` | `Hash` |
| [char_market_orders](https://github.com/aladac/eveapi/wiki/char_market_orders)  | `key_id`, `vcode`, `character_id` | `Array` |
| [char_mail_messages](https://github.com/aladac/eveapi/wiki/char_mail_messages) | `key_id`, `vcode`, `character_id` | `Array` |
| [char_mailing_lists](https://github.com/aladac/eveapi/wiki/char_mailing_lists) | `key_id`, `vcode`, `character_id` | `Array` |
| [char_industry_jobs](https://github.com/aladac/eveapi/wiki/char_industry_jobs)  | `key_id`, `vcode`, `character_id` | `Array` |
| [char_contact_notifications](https://github.com/aladac/eveapi/wiki/char_contact_notifications)  | `key_id`, `vcode`, `character_id` | `Array` |
| [char_contact_list](https://github.com/aladac/eveapi/wiki/char_contact_list) | `key_id`, `vcode`, `character_id` | `Array` |
| [char_character_sheet](https://github.com/aladac/eveapi/wiki/char_character_sheet) | `key_id`, `vcode`, `character_id` | `Hash` |
| [char_asset_list](https://github.com/aladac/eveapi/wiki/char_asset_list) | `key_id`, `vcode`, `character_id` | `Array` |
| [char_account_balance](https://github.com/aladac/eveapi/wiki/char_account_balance)  | `key_id`, `vcode`, `character_id` | `Array` |

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
