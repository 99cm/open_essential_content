lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'open_essential_content/version'

Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY 
  s.name        = 'open_essential_content'
  s.version     = OpenEssentialContent.version
  s.authors     = 'Leo Wang'
  s.email       = 'dotcom@china-guide.com'
  s.homepage    = 'https://github.com/99cm/open_essential_content'
  s.summary     = 'Open Essential Content provides a CMS for Open Store sites. See readme for details'
  s.description = 'Open Essential Content provides a CMS for Open Store site, static pages and blogs.'
  s.required_ruby_version = '>= 2.5.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path  = 'lib'
  s.requirements << 'none'

  s.add_dependency 'open_core', version
  s.add_dependency 'open_backend', version
  s.add_dependency 'open_frontend', version
  s.add_dependency 'open_auth_devise', version
  s.add_runtime_dependency('acts-as-taggable-on')

  s.add_development_dependency 'capybara', '~> 2.18.0'
  s.add_development_dependency 'capybara-screenshot'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3', '~> 1.3.6'
  s.add_development_dependency 'pry-rails'
end