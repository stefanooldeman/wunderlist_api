require 'spec_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'


RspecApiDocumentation.configure do |config|
  config.app = Webmachine.application.adapter
  config.format = [:json, :combined_text, :html]
  config.api_name = "Wunderlist API"
end
