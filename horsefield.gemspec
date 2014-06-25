# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'horsefield/version'

Gem::Specification.new do |spec|
  spec.name          = "horsefield"
  spec.version       = Horsefield::VERSION
  spec.authors       = ["Erik Strömberg"]
  spec.email         = ["erik.stromberg@gmail.com"]
  spec.description   = %q{It's a scraper}
  spec.summary       = %q{It's a scraper}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features|lib)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'nokogiri'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock", "1.12.0"
  spec.add_development_dependency "watir-webdriver"
  spec.add_development_dependency "guard-rspec"
end
