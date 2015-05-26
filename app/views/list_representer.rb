require 'roar/json'
require 'roar/json/hal'

module ListRepresenter
  include Roar::JSON::HAL

  property :name
  property :public
  property :created_at

  link :back do; Wunderlist.uri(ListsRepresenter, :self) end
  link :self do; Wunderlist.uri(ListRepresenter, :self).gsub(':list', name) end
  links :tasks do
    self.tasks.map do |task_item|
      task_item.extend(TaskRepresenter)
      { name: task_item.title, href: task_item.href_self }
    end
  end

  def href_self
    self.to_hash['_links']['self']['href']
  end
end
