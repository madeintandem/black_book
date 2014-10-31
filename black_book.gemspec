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

  spec.add_dependency "symboltable"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock", "~> 1.10.0" # Locked at 1.10.x to prevent VCR warnings
  spec.add_development_dependency "mocha"
end
