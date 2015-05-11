class BaseResource < Webmachine::Resource

  CORS_HEADERS = {
    'Access-Control-Allow-Methods' => 'GET, POST, OPTIONS', # HEAD, DELETE, PUT
    'Access-Control-Allow-Headers' => 'Origin, Content-Type, Accept', # Authorization
    'Access-Control-Allow-Credentials' => 'true'
  }

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

  def finish_request
    CORS_HEADERS.each { |k,v| response.headers[k] = v }

    if request.headers[:origin]
      response.headers['Access-Control-Allow-Origin'] = request.headers[:origin]
    end
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
