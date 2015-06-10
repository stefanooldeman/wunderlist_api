class Lists::TaskResource < ModelResource

  def uid_sym; :task_id end

  def allowed_methods
    ['GET', 'OPTIONS']
  end

  protected

  def allow_empty_collection; true end

  def find_resource
    Task.where(task_list_id: list_id, id: params[uid_sym])
  end

  def represent_resource(record)
    record.extend(Lists::TaskRepresenter)
  end

  def find_collection
    TaskList.where(id: 'archive', public: true).first_or_create
    Task.where(task_list_id: list_id).each.to_a
  end

  def represent_collection(records)
    OpenStruct.new(tasks: records, list_id: list_id).extend(Lists::TasksRepresenter)
  end

  private

  def list_id
    @_list ||= TaskList.where(id: params[:list_id]).first
    @_list.id if @_list
  end
end
