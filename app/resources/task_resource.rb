class TaskResource < ModelResource

  def uid_sym; :task_id end

  def allowed_methods
    if request.path_info[uid_sym].nil?
      ['GET', 'POST', 'OPTIONS']
    else
      ['GET', 'DELETE', 'OPTIONS']
    end
  end

  protected

  def from_json
    @result = Task.create!(params.merge(archived: false, id: @next_id))
    response.body = represent_resource(@result).to_json
  end
  
  def to_json
    @result.to_json
  end

  def href_self
    represent_resource(Task.new(id: @next_id)).href_self
  end

  def find_resource
    Task.where(id: params[uid_sym])
  end

  def represent_resource(record)
    record.extend(TaskRepresenter)
  end

  def find_collection
    Task.each.to_a
  end

  def represent_collection(records)
    OpenStruct.new(tasks: records).extend(TasksRepresenter)
  end
end
