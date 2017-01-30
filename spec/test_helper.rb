# encoding: UTF-8
# frozen_string_literal: true
require 'rack/test'

module TestHelper
  include Rack::Test::Methods

  def mock_app(&block)
    @app = Sinatra.new(Sinatra::Base) do
      class_eval(&block)
    end
  end

  def app
    @app
  end

  def json
    JSON.parse(last_response.body, :symbolize_names => true)
  end
end
