class TaskResource < Webmachine::Resource
  def allowed_methods
    ['GET', 'POST']
  end

end
