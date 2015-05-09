class TaskResource < Webmachine::Resource

  def allowed_methods
    ['GET', 'POST']
  end

  def post_is_create?; true; end
  def allow_missing_post?; true; end # equals to resource_exists? return true if params[:id].blank?

  def create_path
    # TaskRepresentation.from_attributes(:id => @task.id)
    #   .to_json.links[:self]
    '/tasks/1'
  end

  def resource_exists?
    @task = TaskItem.find(params[:id]) if params[:id]
    @task.present?
  end

  def content_types_provided
    [["application/json", :to_json]]
  end

  def content_types_accepted
    [["application/json", :from_json]]
  end

  def from_json
    @task = TaskItem.create!(params.except(:id))
    to_json
  end
  
  def to_json
    TaskRepresenter.new(@task).to_json
  end

  protected

  def params
    data = if request.body.to_s
      JSON.parse(request.body.to_s).merge(request.path_info)
    else
      request.path_info
    end
    data.with_indifferent_access
  end
end
