require 'roar/json'
require 'roar/decorator'

class TaskRepresenter < Roar::Decorator
  include Roar::JSON
  include Roar::Hypermedia
  
  property :id
  property :title
  property :archived
  property :created_at

  link :self do
    "/tasks/#{represented.id}"
  end
end
