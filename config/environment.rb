

require 'bundler/setup'
Bundler.require(:default, :development)

require 'net/http'
require 'json'
require 'open-uri'
require 'pry'
require 'table_print'
require 'time'
require 'launchy'


require_relative '../lib/filter.rb'
require_relative '../lib/get_requester.rb'
require_relative '../lib/cli.rb'


