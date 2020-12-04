#!/usr/bin/env ruby

require_relative '../config/environment.rb'

hello = UserInterface.new
hello.user_experience
GetRequester(hello.section)
