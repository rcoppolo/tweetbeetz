# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "freesound/version"

Gem::Specification.new do |s|
  s.name        = "freesound-ruby"
  s.version     = Freesound::VERSION
  s.authors     = ["Alex Genco"]
  s.email       = ["alexgenco@gmail.com"]
  s.homepage    = "https://github.com/alexgenco/freesound-ruby"
  s.summary     = %q{Freesound.org API wrapper in Ruby.}
  s.description = %q{A wrapper for the Freesound.org API, to provide access to their extensive audio database.}

  s.rubyforge_project = "freesound-ruby"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  #s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency("rspec")
  s.add_development_dependency("bundler", "~> 1.0.0")
  s.add_development_dependency("webmock")
  s.add_runtime_dependency("crack")
end
