# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ghstats/version'

Gem::Specification.new do |spec|
  spec.name          = "ghstats"
  spec.version       = GHStats::VERSION
  spec.authors       = ["Bartosz Kopiński"]
  spec.email         = ["bartosz@kopinski.pl"]
  spec.summary       = "Fetching GitHub stats"
  spec.license       = "MIT"

  spec.files         = %w(LICENSE.txt README.md ghstats.gemspec) + Dir['bin/*'] + Dir['lib/**/*.rb']
  spec.executables   = Dir['bin/*'].map { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_dependency "octokit", "~> 3.8"
end
