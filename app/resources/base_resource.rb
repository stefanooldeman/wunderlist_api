class BaseResource < Webmachine::Resource

  def post_is_create?; true; end
  def allow_missing_post?; true; end # equals to resource_exists? return true if params[:id].blank?

  def handle_exception e
    response.headers['Content-Type'] = 'application/json'
    response.body = { message: e.message, backtrace: e.backtrace }.to_json
  end

  def content_types_provided
    [["application/json", :to_json]]
  end

  def content_types_accepted
    [["application/json", :from_json]]
  end

  protected

  def params
    data = if request.body.to_s.present?
      JSON.parse(request.body.to_s).merge(request.path_info)
    else
      request.path_info
    end
    data.with_indifferent_access
  end

end
