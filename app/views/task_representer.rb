require 'roar/json'
require 'roar/decorator'
require 'roar/json/hal'

class TaskRepresenter < Roar::Decorator
  include Roar::JSON
  include Roar::JSON::HAL
  
  property :id
  property :title
  property :archived
  property :created_at

  link :self do
    "/tasks/#{represented.id}"
  end
end
