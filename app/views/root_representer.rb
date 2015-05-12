require 'roar/decorator'
require 'roar/json/hal'

class RootRepresenter < Roar::Decorator
  include Roar::JSON::HAL

  def self.build
    new(OpenStruct.new)
  end
  
  link :self do
    '/'
  end

  link :tasks do
    '/tasks'
  end

  link :lists do
    '/lists'
  end

  link :auth do
    '/auth'
  end

  link :users do
    '/users'
  end
end
