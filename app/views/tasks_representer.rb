require 'roar/json'
require 'roar/json/hal'

module TasksRepresenter
  include Roar::JSON::HAL

  link :self do; Wunderlist.uri(:tasks_representer, :self) end
  link :back do; Wunderlist.uri(:root_representer, :self) end

  # collection :tasks, class: Task, extend: TaskRepresenter, embedded: true
  links :tasks do
    self.tasks.map do |task|
      task.extend(TaskRepresenter)
      { name: task.title, href: task.href_self }
    end
  end
end
