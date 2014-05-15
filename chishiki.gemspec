# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chishiki/version'

date = "2014-05-06"

Gem::Specification.new do |spec|
  spec.name          = "chishiki"
  spec.version       = Chishiki::VERSION
  spec.authors       = ["Kevin Vollmer"]
  spec.email         = ["works.kvollmer@gmail.com"]
  spec.summary       = ["Chishiki is a writing app that structures ideas in branches."]
  spec.description   = [""]
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
