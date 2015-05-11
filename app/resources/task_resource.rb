class TaskResource < BaseResource
  def trace?
    false
  end

  def allowed_methods
    ['GET', 'POST', 'OPTIONS']
  end

  def create_path
    TaskRepresenter.from_attributes(:id => 1)
       .to_json.links[:self]
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
    @result = TaskItem.create!(params.except(:id))
    to_json
  end
  
  def to_json
    @result.to_json
  end
end
