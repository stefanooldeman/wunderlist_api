require 'roar/json'

class Task
  include Roar::JSON
  include Roar::Hypermedia
  
  property :name
  property :id
  property :date

  link :self do
    "/products/#{id}"
  end
end
