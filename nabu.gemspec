$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nabu/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nabu"
  s.version     = Nabu::VERSION
  s.authors     = ["Tobias Schmidt"]
  s.email       = ["t.schmidt@rubidat.de"]
  s.homepage    = "http://babylon-online.org"
  s.summary     = "Threaded comment system for babylon-online."
  s.description = "Threaded comment system for babylon-online."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails"
  s.add_dependency 'redcarpet'
  s.add_dependency 'closure_tree', '~> 6.5.0'
  s.add_dependency 'search_cop'
  s.add_dependency 'simple_form'
  s.add_dependency 'bootstrap-sass', '~> 3.3.6'
  s.add_dependency 'will_paginate-bootstrap'
  s.add_dependency 'rails-bootstrap-markdown'

  s.add_development_dependency "sqlite3"
end
