
Webmachine.application.routes do
  add ["tasks"], TaskResource
  add ["tasks", :id], TaskResource

  # TODO only in development?!
  add ['trace', :*], Webmachine::Trace::TraceResource
end
