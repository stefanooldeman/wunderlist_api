require 'roar/json'
require 'roar/json/hal'

# TODO check how to extend a different module
module Lists::TaskRepresenter
  include Roar::JSON::HAL

  property :id
  property :archived
  property :created_at
  property :title

  link :self do
    Wunderlist.uri(ListRepresenter, :task)
      .gsub(':list_id', list_id)
      .gsub(':task_id', id.to_s)
  end
  link :back do;
    Wunderlist.uri(ListRepresenter, :tasks)
      .gsub(':list_id', list_id)
  end

  def href_self
    self.to_hash['_links']['self']['href']
  end
end
