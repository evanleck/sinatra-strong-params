# coding: utf-8
$:.unshift File.expand_path("../lib", __FILE__)
require 'sinatra/strong-params/version'

Gem::Specification.new do |spec|
  spec.name          = "sinatra-strong-params"
  spec.version       = Sinatra::StrongParams::VERSION
  spec.authors       = ["Evan Lecklider"]
  spec.email         = ["evan@lecklider.com"]
  spec.summary       = %q{Some super basic strong parameter filters for Sinatra.}
  spec.description   = spec.summary
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'sinatra', '>= 1.4.0'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack-test"
end
