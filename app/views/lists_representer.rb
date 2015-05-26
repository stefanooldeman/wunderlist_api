require 'roar/json'
require 'roar/json/hal'

module ListsRepresenter
  include Roar::JSON::HAL

  link :self do; Wunderlist.uri(ListsRepresenter, :self) end
  link :back do; Wunderlist.uri(RootRepresenter, :self) end
  links :lists do
    self.lists.map do |task_list|
      task_list.extend(ListRepresenter)
      { name: task_list.name, href: task_list.href_self }
    end
  end
end
