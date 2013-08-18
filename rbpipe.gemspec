# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rbpipe/version'

Gem::Specification.new do |spec|
  spec.name          = "rbpipe"
  spec.version       = Rbpipe::VERSION
  spec.authors       = ["typd"]
  spec.email         = ["othertang@gmail.com"]
  spec.description   = %q{ruby pipe}
  spec.summary       = %q{ruby pipe}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
end
