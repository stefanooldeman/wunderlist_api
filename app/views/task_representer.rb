require 'roar/json'
require 'roar/json/hal'

module TaskRepresenter
  include Roar::JSON::HAL

  property :id
  property :title
  property :archived
  property :created_at

  link :self do
    Wunderlist.uri(TaskRepresenter, :self)
      .gsub(':id', id.to_s)
  end

  def href_self
    self.to_hash['_links']['self']['href']
  end
end
