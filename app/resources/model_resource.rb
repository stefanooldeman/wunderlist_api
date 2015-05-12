class ModelResource < BaseResource

  def create_path
    @next_id = BSON::ObjectId.from_time(Time.now.to_f, unique: true)
    href_self # to_be_implemented
  end

  def resource_exists?
    @result = if params[:id].present?
      find_resource # to_be_implemented
    else
      find_collection # to_be_implemented
    end
    @result.present?
  end
  
  def to_json
    @result.to_json
  end
end

