# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "black_book/version"

Gem::Specification.new do |spec|
  spec.name          = "black_book"
  spec.version       = BlackBook::VERSION
  spec.authors       = ["Tony Coconate", "Cory Stephenson", "Dayton Nolan", "Tony Rosario"]
  spec.email         = ["me@tonycoconate.com", "aevin@me.com", "daytonn@gmail.com", "tony.rosario@gmail.com"]
  spec.description   = %q{Provides a ruby interface for the Black Book's API. Read more about it here: http://www.blackbookusa.com}
  spec.summary       = %q{A ruby interface for Black Book's API}
  spec.homepage      = "http://github.com/devmynd/black_book"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "json"
  spec.add_dependency "rest-client", "~> 1.7"
  spec.add_dependency "symboltable", "~> 1.0"

  spec.add_development_dependency "awesome_print", "~> 1.2"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "fuubar", "~> 2.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "pry-nav", "~> 0.2"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "vcr", "~> 2.9"
  spec.add_development_dependency "webmock", "~> 1.10"
end
