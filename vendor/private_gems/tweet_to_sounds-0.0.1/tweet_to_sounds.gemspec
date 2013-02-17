# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tweet_to_sounds/version'

Gem::Specification.new do |gem|
  gem.name          = "tweet_to_sounds"
  gem.version       = TweetToSounds::VERSION
  gem.authors       = ["Ryan Fitzgerald"]
  gem.email         = ["rwfitzge@gmail.com"]
  gem.description   = %q{}
  gem.summary       = %q{}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "freesound-ruby"

  gem.add_development_dependency "minitest"
  gem.add_development_dependency "mocha"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "vcr"
  gem.add_development_dependency "webmock"
end
