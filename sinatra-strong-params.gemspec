# encoding: UTF-8
# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'sinatra/strong-params/version'

Gem::Specification.new do |spec|
  spec.name          = 'sinatra-strong-params'
  spec.version       = Sinatra::StrongParams::VERSION
  spec.authors       = ['Evan Lecklider', 'Gustavo Sobral']
  spec.email         = ['evan@lecklider.com', 'ghsobral@gmail.com']
  spec.summary       = 'Basic strong parameter filters for Sinatra.'
  spec.homepage      = 'https://github.com/evanleck/sinatra-strong-params'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'sinatra', '>= 1.4.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rack-test'
end
