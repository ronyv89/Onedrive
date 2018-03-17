# frozen_string_literal: true

lib = File.expand_path(__dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lib/onedrive_graph/version'

Gem::Specification.new do |spec|
  spec.name          = 'onedrive_graph'
  spec.version       = OnedriveGraph::VERSION
  spec.authors       = ['Rony Varghese']
  spec.email         = ['ronyv250289@gmail.com']
  spec.summary       = 'Onedrive REST API wrapper for Ruby'
  spec.homepage      = 'https://github.com/ronyv89/onedrive'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'yardstick'
  spec.add_dependency 'httparty'
  spec.add_dependency 'oauth2'
end
