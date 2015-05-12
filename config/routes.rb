
Webmachine.application.routes do
  add ['user', :username, 'tasks'], UserTaskResource
  add ['user', :username, 'tasks', :id], UserTaskResource

  add ['tasks'], TaskResource
  add ['tasks', :id], TaskResource

  # TODO only in development?!
  add ['trace', :*], Webmachine::Trace::TraceResource
  add ['*'], RootResource # add proxy in nginx.. * is weird
end
