class TaskResource < ModelResource
  # def trace?; true; end

  def allowed_methods
    if request.path_info[:id].nil?
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
    @result = TaskItem.create!(params.merge(archived: false, id: @next_id))
    response.body = @result.extend(TaskRepresenter).to_json
  end
  
  def to_json
    @result.to_json
  end

  def href_self
    TaskItem.new(id: @next_id).extend(TaskRepresenter)
      .href_self
  end

  def find_resource
    query = TaskItem.where(id: params[:id])
    if query.exists?
      query.first.extend(TaskRepresenter)
    end
  end

  def find_collection
    records = TaskItem.each.to_a
    unless records.empty?
      TaskList.new(records).extend(TasksRepresenter)
    end
  end
end
