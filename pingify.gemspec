# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pingify/version'

Gem::Specification.new do |spec|
  spec.name          = "pingify"
  spec.version       = Pingify::VERSION
  spec.authors       = ["tor"]
  spec.email         = ["torkale@gmail.com"]
  spec.description   = %q{Pingify is a simple library that enables simple ping checks on running service }
  spec.summary       = %q{ping checks}
  spec.homepage      = "https://github.com/tor-ivry/pingify"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "webmock"
  spec.add_dependency "rest-client"
end
