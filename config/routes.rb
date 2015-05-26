require 'uri'

TASK = 'tasks'
LIST = 'lists'
USER = 'users'

Webmachine.application.routes do
  # add [USER, :username, TASK], UserTaskResource
  # add [USER, :username, TASK, :id], UserTaskResource

  add [TASK], TaskResource
  add [TASK, :task_id], TaskResource

  add [LIST], ListsResource
  add [LIST, :list_id], ListsResource
  add [LIST, :list_id, TASK], TaskResource
  add [LIST, :list_id, TASK, :task_id], TaskResource

  # TODO only in development?!
  add ['trace', :*], Webmachine::Trace::TraceResource
  add [:*], RootResource # add proxy in nginx.. * is weird
end

Wunderlist.configure do |config|
  config.root_representer = {
    self: '/',
    auth: '/auth',
    tasks: TASK,
    users: USER,
    lists: LIST,
  }

  config.task_representer = {
    self: "#{TASK}/:id"
  }

  config.tasks_representer = {
    self: TASK
  }

  config.list_representer = {
    self: "#{LIST}/:list",
    tasks: "#{LIST}/:list/tasks"
  }

  config.lists_representer = {
    self: LIST,
  }
end
