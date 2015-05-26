class TaskResource < ModelResource
  # def trace?; true; end
  def uid_sym; :task_id end

  def allowed_methods
    if request.path_info[uid_sym].nil?
      ['GET', 'POST', 'OPTIONS']
    else
      ['GET', 'DELETE', 'OPTIONS']
    end
  end

  def delete_resource
    @result.destroy
    response.body = @result.extend(TaskRepresenter).to_json
    true
  end

  protected

  def from_json
    @result = Task.create!(params.merge(archived: false, id: @next_id))
    response.body = @result.extend(TaskRepresenter).to_json
  end
  
  def to_json
    @result.to_json
  end

  def href_self
    Task.new(id: @next_id).extend(TaskRepresenter)
      .href_self
  end

  def find_resource
    query = Task.where(id: params[uid_sym])
    if query.exists?
      query.first.extend(TaskRepresenter)
    end
  end

  def find_collection
    records = Task.each.to_a
    unless records.empty?
      collection = OpenStruct.new(tasks: records)
      collection.extend(TasksRepresenter)
    end
  end
end
