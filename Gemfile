source 'https://rubygems.org'

gemspec

group :development do
  gem 'rake',		'~> 0.8.7'

  case RUBY_PLATFORM
  when 'java'
    gem 'maruku',	'~> 0.6.0'
  else
    gem 'rdiscount',	'~> 1.6.3'
  end

  gem 'ore',		'~> 0.2.0'
  gem 'ore-tasks',	'~> 0.1.2'
  gem 'rspec',		'~> 2.0.0'
end
