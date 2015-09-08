![EVEApi for ruby](https://github.com/aladac/eveapi/raw/master/doc/eveapi.png)

*EVE API for ruby*

[![Build Status](https://secure.travis-ci.org/aladac/eveapi.svg?branch=master)](https://travis-ci.org/aladac/eveapi)
[![Code Climate](https://codeclimate.com/github/aladac/eveapi/badges/gpa.svg)](https://codeclimate.com/github/aladac/eveapi)
[![Test Coverage](https://codeclimate.com/github/aladac/eveapi/badges/coverage.svg)](https://codeclimate.com/github/aladac/eveapi/coverage)

## Disclaimer!
This work in progress in a very early stage. Not documented. Only a couple of methods are tested.

Most methods names can be listed by calling `EVEApi::Client#api_methods`
```ruby
EVEApi::Client.new.api_methods[0..5]
=> [
    [0] :char_chat_channels,
    [1] :char_bookmarks,
    [2] :char_locations,
    [3] :char_contracts,
    [4] :char_account_status,
    [5] :char_character_info
]
```
Most methods requiring arguments other than `character_id`, `key_id`, `vcode` and `row_count` probably will not function correctly.

Because of the way the paths are being built from the method names - some methods may look funky eq. `server_server_status`.

`account_characters`, `char_character_sheet`, `char_wallet_journal`, `server_server_status`, `account_api_key_info`, `api_call_list` should work.

## Description

EVE Online API Client for ruby

## Features

Uses [excon](https://github.com/excon/excon),  [crack](https://github.com/jnunemaker/crack), `method_missing` and a couple of rescue blocks to automate access to EVE Online API.
- returns results as `Hash` or `Array`
- raises exceptions with messages from the API itself
- converts ruby methods like `account_api_info` to an EVE Online API request like `GET /account/APIKeyInfo.xml.aspx` along with query params.

## Examples

```ruby
require 'eveapi'
client = EVEApi::Client.new
client.key_id = 4278167
client.vcode = "7QJg6p5BZNpDBp2FIz39dGwa7jnNaXAuYyLUVitlTQ3rY60VPBcaTpJVfYIkiW5l"
client.account_characters
client.account_characters
=> {
                :name => "Quint Slade",
        :character_id => "95512059",
    :corporation_name => "Imperial Academy",
      :corporation_id => "1000166",
         :alliance_id => "0",
       :alliance_name => "",
          :faction_id => "0",
        :faction_name => ""
}
```

## Requirements
`excon` and `crack` automatically installed as dependencies during `gem install`, or `bundle install` in development.

## Install

    $ gem install eveapi

## Copyright

Copyright (c) 2015 Adam Ladachowski

See LICENSE.txt for details.
