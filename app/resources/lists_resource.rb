class ListsResource < ModelResource

  def uid_sym; :list_id end

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
    @result = TaskItem.create!(params.merge(archived: false, id: @next_id))
    response.body = @result.extend(TaskRepresenter).to_json
  end
  
  def to_json
    @result.to_json
  end

  def href_self
    TaskList.new(id: @next_id).extend(ListRepresenter)
      .href_self
  end

  def find_resource
    query = TaskList.where(name: params[uid_sym])
    if query.exists?
      query.first.extend(ListRepresenter)
    end
  end

  def find_collection
    TaskList.where(name: 'archive', public: true).first_or_create
    records = TaskList.each.to_a
    unless records.empty?
      collection = OpenStruct.new(lists: records)
      collection.extend(ListsRepresenter)
    end
  end
end
