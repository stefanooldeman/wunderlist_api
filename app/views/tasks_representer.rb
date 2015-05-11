require 'roar/json'
require 'roar/json/hal'

module TasksRepresenter
  include Roar::JSON
  include Roar::JSON::HAL

  collection :tasks, class: TaskItem, extend: TaskRepresenter, embedded: true

  link :self do
    '/tasks'
  end
end
