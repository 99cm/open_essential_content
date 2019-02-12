source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'open', github: '99cm/open', branch: 'master'
gem 'open_auth_devise', github: '99cm/open_auth_devise'
gem 'rails-controller-testing'

gem 'globalize', github: 'globalize/globalize'
gem 'open_i18n', github: '99cm/open_i18n'
gem 'open_globalize', github: '99cm/open_globalize', branch: 'master'

gemspec