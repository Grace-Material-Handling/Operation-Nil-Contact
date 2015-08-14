#!/usr/bin/env ruby
require 'rubygems'
require 'nutshell-crm-api'
require 'csv'

# nutshell credentials
$username = ARGV[0]
$apiKey   = ARGV[1]

# start app
require "./app.rb"