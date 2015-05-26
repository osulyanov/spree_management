# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spree_management/version'

Gem::Specification.new do |spec|
  spec.platform    = Gem::Platform::RUBY
  spec.name          = "spree_management"
  spec.version       = SpreeManagement::VERSION
  spec.authors       = ["osulyanov"]
  spec.email         = ["oleg@sulyanov.com"]
  spec.summary       = %q{Add batch action to Spree admin panel}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.required_ruby_version = '>= 1.9.3'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "iconv"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'capybara', '~> 2.1'
  spec.add_development_dependency 'coffee-rails'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'factory_girl', '~> 4.4'
  spec.add_development_dependency 'ffaker'
  spec.add_development_dependency 'rspec-rails',  '~> 2.13'
  spec.add_development_dependency 'sass-rails', '~> 4.0.2'
  spec.add_development_dependency 'selenium-webdriver'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'sqlite3'
end
