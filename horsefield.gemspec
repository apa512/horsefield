# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'horsefield/version'

Gem::Specification.new do |spec|
  spec.name          = "horsefield"
  spec.version       = Horsefield::VERSION
  spec.authors       = ["Erik Strömberg"]
  spec.email         = ["erik.stromberg@gmail.com"]
  spec.summary       = %q{It's a scraper}
  spec.homepage      = "http://github.com/apa512/horsefield"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'nokogiri'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "guard-minitest"
  spec.add_development_dependency "pry"
end
