# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activeadmin/selectize/version'

Gem::Specification.new do |spec|
  spec.name          = 'activeadmin_selectize'
  spec.version       = ActiveAdmin::Selectize::VERSION
  spec.summary       = 'Selectize for ActiveAdmin'
  spec.description   = 'An Active Admin plugin to use Selectize.js (jQuery required)'
  spec.license       = 'MIT'
  spec.authors       = ['Mattia Roccoberton']
  spec.email         = 'mat@blocknot.es'
  spec.homepage      = 'https://github.com/blocknotes/activeadmin_selectize'

  spec.files         = Dir['{app,lib}/**/*', 'LICENSE.txt', 'Rakefile', 'README.md']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activeadmin', '~> 2.0'
  spec.add_runtime_dependency 'sassc', '~> 2.4'
end
