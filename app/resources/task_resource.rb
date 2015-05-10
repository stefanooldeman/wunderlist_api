class TaskResource < BaseResource
  def trace?
    false
  end

  def allowed_methods
    ['GET', 'POST']
  end

  def create_path
    TaskRepresenter.from_attributes(:id => 1)
       .to_json.links[:self]
  end

  def resource_exists?
    @result = if params[:id].blank?
      TaskItem.each.map { |model| TaskRepresenter.new(model) }
    end
    @result.present?
  end

  def from_json
    @result = TaskItem.create!(params.except(:id))
    to_json
  end
  
  def to_json
    { tasks: @result }.to_json
  end
end
