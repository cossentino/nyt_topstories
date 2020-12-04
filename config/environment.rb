

require 'bundler/setup'
Bundler.require(:default, :development)

require 'net/http'
require 'json'
require 'open-uri'
require 'pry'
require 'table_print'
require 'time'

require_relative '../lib/get_requester.rb'
require_relative '../lib/user_interface.rb'

