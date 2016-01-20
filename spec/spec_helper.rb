require 'bundler/setup'
Bundler.setup

require 'webmock/rspec'
require 'consul_loader' # and any other gems you need
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

RSpec.configure do |config|
  # some (optional) config here
end
