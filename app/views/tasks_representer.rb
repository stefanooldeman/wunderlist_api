require 'roar/json'
require 'roar/json/hal'

module TasksRepresenter
  include Roar::JSON::HAL

  link :self do; Wunderlist.uri(:tasks_representer, :self) end
  link :back do; Wunderlist.uri(:root_representer, :self) end

  # collection :tasks, class: TaskItem, extend: TaskRepresenter, embedded: true
  links :tasks do
    self.tasks.map do |task_item|
      task_item.extend(TaskRepresenter)
      { name: task_item.title, href: task_item.href_self }
    end
  end
end
