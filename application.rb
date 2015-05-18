require 'mongoid'

require 'webmachine'
require 'webmachine/adapters/rack'

require 'active_support/core_ext'
require 'active_support/dependencies'

%w(lib app/views app/models app/resources).each do |modules|
  ActiveSupport::Dependencies.autoload_paths << "./#{modules}"
end

Mongoid.load!('./config/mongoid.yml')

require './config/environment.rb'
require './config/routes.rb'


Webmachine.application.configure do |config|
  config.ip = Application.config.server_host
  config.port = Application.config.server_port
  config.adapter = :Rack # not well documented
end
