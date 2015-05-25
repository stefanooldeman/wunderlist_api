require 'uri'

TASK = 'tasks'
USER = 'users'

Webmachine.application.routes do
  # add [USER, :username, TASK], UserTaskResource
  # add [USER, :username, TASK, :id], UserTaskResource

  add [TASK], TaskResource
  add [TASK, :id], TaskResource

  # TODO only in development?!
  add ['trace', :*], Webmachine::Trace::TraceResource
  add ['*'], RootResource # add proxy in nginx.. * is weird
end

Wunderlist.configure do |config|
  config.root_representer = {
    self: '/',
    auth: '/auth',
    tasks: TASK,
    users: USER,
    archive: '/archive',
  }

  config.task_representer = {
    self: "#{TASK}/:id"
  }

  config.tasks_representer = {
    self: TASK
  }
end
