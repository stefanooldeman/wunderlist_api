require 'rubygems'
require 'bundler/setup'
Bundler.require(:test)

ENV['RACK_ENV'] = 'test'

require './application'

RSpec.configure do |config|
  config.include Mongoid::Matchers, type: :model
  config.include JsonSpec::Helpers # https://github.com/collectiveidea/json_spec/blob/master/README.md
  config.include FactoryGirl::Syntax::Methods

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
  config.before(:suite) do
    begin
      FactoryGirl.find_definitions
      FactoryGirl.lint
      DatabaseCleaner.start
    ensure
      DatabaseCleaner.clean
    end
  end
end
