require 'roar/json'
require 'roar/decorator'

class TaskRepresenter < Roar::Decorator
  include Roar::JSON
  include Roar::Hypermedia
  
  property :id
  property :title
  property :completed_at
  property :created_at

  # link :self do
  #   "/tasks/#{id}"
  # end
end
