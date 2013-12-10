# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yahoo_parse_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'yahoo_parse_api'
  spec.version       = YahooParseApi::VERSION
  spec.authors       = ['kyohei8']
  spec.email         = ['tsukuda.kyouhei@gmail.com']
  spec.description   = %q{yahoo parse API client}
  spec.summary       = %q{yahoo parse API client}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'httparty'

  spec.add_development_dependency 'bundler', '~> 1.3.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
end
