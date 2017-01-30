ENV['RACK_ENV'] = 'test'

require 'rspec'
require_relative 'test_helper'

RSpec.configure do |config|
  config.mock_framework = :rspec
  config.include TestHelper
end