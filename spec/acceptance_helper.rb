require File.dirname(__FILE__) + '/spec_helper'

require 'capybara'
require 'capybara/rspec'

#Capybara.default_driver = :selenium

Capybara.app = MyApp.new

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers
end
