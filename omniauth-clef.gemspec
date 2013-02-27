# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'omniauth/clef/version'

Gem::Specification.new do |s|
  s.name     = 'omniauth-clef'
  s.version  = OmniAuth::Clef::VERSION
  s.authors  = ['Jesse Pollak']
  s.email    = ['jpollak92@gmail.com']
  s.summary  = 'Clef strategy for OmniAuth'
  s.homepage = 'https://github.com/jessepollak/omniauth-clef'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_runtime_dependency 'omniauth-oauth2', '~> 1.1'
  s.add_development_dependency 'pry'

  s.add_development_dependency 'minitest'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'rake'
end
