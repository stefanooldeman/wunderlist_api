source "https://rubygems.org"

ruby '2.1.6'

gem 'mongoid'
gem 'rack'
gem 'webmachine'
gem 'roar'
gem 'activesupport'

group :development, :test do
  gem 'pry-byebug'
  gem 'rerun'
  gem 'guard-rspec'
end

group :test do
  gem 'json_spec'
  gem 'database_cleaner'
  gem 'mongoid-rspec'
  # rack-test required for rspec_api_documentation (strange enough)
  gem 'rack-test'
  gem 'rspec_api_documentation'
  gem 'factory_girl'
end
