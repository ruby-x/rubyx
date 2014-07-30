# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'salama'
  s.version = '0.0.1'

  s.authors = ['Torsten Ruger']
  s.email = 'torsten@villataika.fi'
  s.extra_rdoc_files = ['README.markdown']
  s.files = %w(README.md LICENSE.txt Rakefile) + Dir.glob("lib/**/*")
  s.homepage = 'https://github.com/salama-vm/salama'
  s.license = 'MIT'
  s.require_paths = ['lib']
  s.summary = 'Salama (lightning) is a native oo vm without any c'  
  
  s.add_dependency 'parslet', '~> 1.6.1'
end