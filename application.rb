require 'mongoid'

require 'webmachine'
require 'webmachine/adapters/rack'

require 'active_support/core_ext'
require 'active_support/dependencies'

%w(views models resources).each do |modules|
  ActiveSupport::Dependencies.autoload_paths << "./app/#{modules}"
end

Mongoid.load!('./config/mongoid.yml')

require './config/routes.rb'

Webmachine.application.configure do |config|
  config.ip = '0.0.0.0'
  config.port = 3000
  config.adapter = :Rack # not well documented
end
