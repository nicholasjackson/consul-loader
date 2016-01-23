require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'bundler/setup'
Bundler.setup

require 'webmock/rspec'
require 'consul_loader' # and any other gems you need

 WebMock.disable_net_connect!(:allow => "codeclimate.com")

RSpec.configure do |config|
  # some (optional) config here
end
