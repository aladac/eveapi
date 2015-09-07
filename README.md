![EVEApi for ruby](https://github.com/aladac/itt/eveapi/master/doc/eveapi.png)

*EVE API for ruby*

[![Build Status](https://secure.travis-ci.org/aladac/eveapi.svg?branch=master)](https://travis-ci.org/aladac/eveapi)
[![Code Climate](https://codeclimate.com/github/aladac/eveapi/badges/gpa.svg)](https://codeclimate.com/github/aladac/eveapi)
[![Test Coverage](https://codeclimate.com/github/aladac/eveapi/badges/coverage.svg)](https://codeclimate.com/github/aladac/eveapi/coverage)

## Description

EVE Online API Client for ruby

## Features

Uses [excon](https://github.com/excon/excon),  [crack](https://github.com/jnunemaker/crack), `method_missing` and a couple of rescue blocks to automate access to EVE Online API.
- returns results as `Hash` or `Array`
- converts ruby methods like `account_api_info` to an EVE Online API request like `GET /account/APIKeyInfo.xml.aspx` along with query params.

## Examples

```ruby
require 'eveapi'
client = EVEApi::Client.new
client.key_id = YOUR_API_KEY_ID
client.vcode = YOUR_API_VCODE
client.account_characters
# [{"name"=>"CHARACTER_NAME1", "characterID"=>"CHARACTER_ID1", "corporationName"=>"CORPORATION_NAME1", "corporationID"=>"CORPORATION_ID1", "allianceID"=>"0", "allianceName"=>"", "factionID"=>"0", "factionName"=>""}, {"name"=>"CHARACTER_NAME2", "characterID"=>"CHARACTER_ID2", "corporationName"=>"CORPORATION_NAME2", "corporationID"=>"CORPORATION_ID2", "allianceID"=>"0", "allianceName"=>"", "factionID"=>"0", "factionName"=>""}]
```

## Requirements
`excon` and `crack` automatically installed as dependencies during `gem install`, or `bundle install` in development.

## Install

    $ gem install eveapi

## Copyright

Copyright (c) 2015 Adam Ladachowski

See LICENSE.txt for details.
