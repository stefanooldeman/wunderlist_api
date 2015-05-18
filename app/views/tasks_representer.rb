require 'roar/json'
require 'roar/json/hal'

module TasksRepresenter
  include Roar::JSON::HAL

  link :self do; Wunderlist.uri(:tasks_representer, :self) end

  collection :tasks, class: TaskItem, extend: TaskRepresenter, embedded: true
end
