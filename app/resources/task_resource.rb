class TaskResource < BaseResource
  def trace?
    false
  end

  def allowed_methods
    ['GET', 'POST', 'OPTIONS']
  end

  def create_path
    @next_id = BSON::ObjectId.from_time(Time.now.to_f, unique: true)
    TaskItem.new(id: @next_id).extend(TaskRepresenter)
      .href_self
  end

  def resource_exists?
    @result = if params[:id].present?
      query = TaskItem.where(id: params[:id])
      if query.exists?
        query.first.extend(TaskRepresenter)
      end
    else
      TaskList.new(TaskItem.each.to_a).extend(TasksRepresenter)
    end
    @result.present?
  end

  def from_json
    TaskItem.create!(params.merge(archived: false, id: @next_id))
  end
  
  def to_json
    @result.to_json
  end
end
