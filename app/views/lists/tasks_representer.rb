require 'roar/json'
require 'roar/json/hal'

module Lists::TasksRepresenter
  include Roar::JSON::HAL

  link :self do; Wunderlist.uri(ListRepresenter, :tasks).gsub(':list_id', list_id) end
  link :back do; Wunderlist.uri(ListRepresenter, :self).gsub(':list_id', list_id) end
  links :tasks do
    self.tasks.map do |task|
      task.extend(Lists::TaskRepresenter)
      { name: task.title, href: task.href_self }
    end
  end
end
