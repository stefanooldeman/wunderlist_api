require 'roar/json'
require 'roar/json/hal'

module TaskRepresenter
  include Roar::JSON
  include Roar::JSON::HAL
  
  property :id
  property :title
  property :archived
  property :created_at

  link :self do
    "/tasks/#{id}"
  end
end
