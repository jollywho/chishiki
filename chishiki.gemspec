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
  spec.summary       = ["Chishiki thinking with branches"]
  spec.description   = ["Chishiki is a command-line application for thinking and writing with branches."]
  spec.homepage      = "https://github.com/jollywho/chishiki"
  spec.license       = "WTFPL"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.required_ruby_version = '>= 2.0.0'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
