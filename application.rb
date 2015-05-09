require 'mongoid'
require 'webmachine'
require 'webmachine/adapters/rack'


# require 'active_support/core_ext'
require 'active_support/dependencies'

%w(views models resources).each do |modules|
  ActiveSupport::Dependencies.autoload_paths << "./app/#{modules}"
end

ENV['RACK_ENV'] = 'development' # replaced by deployment / configuration management

Mongoid.load!('./config/mongoid.yml')

Webmachine.application.routes do
  add ["tasks"], TaskResource
  add ["tasks", :id], TaskResource
end

Webmachine.application.configure do |config|
  config.ip = '0.0.0.0'
  config.port = 3000
  config.adapter = :WEBrick
end

# Start a web server to serve requests via localhost
Webmachine.application.run
