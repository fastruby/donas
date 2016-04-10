# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'donas/version'

Gem::Specification.new do |spec|
  spec.name          = "donas"
  spec.version       = Donas::VERSION
  spec.authors       = ["Ernesto Tagwerker"]
  spec.email         = ["ernesto@ombulabs.com"]

  spec.summary       = %q{A simple gem to find DNS information for a domain}
  spec.description   = %q{A wrapper to resolv}
  spec.homepage      = "http://github.com/etagwerker/donas"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = "donas"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "byebug", "~> 8.2.2"
  spec.add_development_dependency "rspec", "~> 3.0"
end
