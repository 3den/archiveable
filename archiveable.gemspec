# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "archiveable/version"

Gem::Specification.new do |spec|
  spec.name          = "archiveable"
  spec.version       = Archiveable::VERSION
  spec.authors       = ["JBailes", "3den"]
  spec.email         = ["j@bailes.us", "eden@3den.biz"]
  spec.summary       = %q{Archiveable concern for rails models}
  spec.description   = %q{Archiveable concern for rails models}
  spec.homepage      = "https://github.com/3den/archiveable"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 4.0.4"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
