class ModelResource < BaseResource

  def delete_resource
    @result.destroy
    response.body = represent_resource(@result).to_json
    true
  end

  def create_path
    @next_id = BSON::ObjectId.from_time(Time.now.to_f, unique: true)
    href_self # to_be_implemented
  end

  def resource_exists?
    @result = if params[uid_sym].present?
      query = find_resource # to_be_implemented
      if query.exists?
        represent_resource(query.first)
      else
        nil
      end
    else
      records = find_collection
      if (records.empty? && allow_empty_collection) || !records.empty?
        represent_collection(records) # to_be_implemented
      else
        nil
      end
    end
    @result.present?
  end
  
  def to_json
    @result.to_json
  end

  def allow_empty_collection
    false
  end

  def uid_sym
    raise NotImplementedError.new
  end

  def find_resource; raise NotImplementedError.new end
  def find_collection; raise NotImplementedError.new end

  def represent_resource(_record); raise NotImplementedError.new end
  def represent_collection(_records); raise NotImplementedError.new end
end

