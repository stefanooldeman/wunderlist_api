class ListsResource < ModelResource

  def uid_sym; :list_id end

  def allowed_methods
    if request.path_info[uid_sym].nil?
      ['GET', 'POST', 'OPTIONS']
    else
      ['GET', 'DELETE', 'OPTIONS']
    end
  end

  def create_path
    represent_resource(TaskList.new(id: params[uid_sym])).href_self
  end

  protected

  def from_json
    params[:id] = params.delete(:name)
    @result = TaskList.create!(params)
    response.body = represent_resource(@result).to_json
  end

  def find_resource
    TaskList.where(id: params[uid_sym])
  end

  def represent_resource(record)
    record.extend(ListRepresenter)
  end

  def find_collection
    # todo arcehive should move to a different resource.rb
    # a.t.m. doing a remove and then get to /lists/archive would fail..
    # also the archive behaves different than other lists.
    # - It should filter tasks on the archive property
    # - It cannot be deleted
    TaskList.where(id: 'archive', public: true).first_or_create
    TaskList.each.to_a
  end

  def represent_collection(records)
    OpenStruct.new(lists: records).extend(ListsRepresenter)
  end
end
