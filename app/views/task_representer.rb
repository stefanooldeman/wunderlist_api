require 'roar/json'
require 'roar/json/hal'

module TaskRepresenter
  include Roar::JSON::HAL

  property :id
  property :archived
  property :created_at
  property :title

  link :self do
    Wunderlist.uri(TaskRepresenter, :self)
      .gsub(':id', id.to_s)
  end
  link :back do; Wunderlist.uri(:tasks_representer, :self) end


  def href_self
    self.to_hash['_links']['self']['href']
  end
end
