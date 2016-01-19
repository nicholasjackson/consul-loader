require 'bundler/setup'
Bundler.setup

require 'webmock/rspec'
require 'consul_loader' # and any other gems you need

RSpec.configure do |config|
  # some (optional) config here
end
