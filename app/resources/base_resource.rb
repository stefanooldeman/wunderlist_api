class BaseResource < Webmachine::Resource

  def post_is_create?; true; end
  def allow_missing_post?; true; end # equals to resource_exists? return true if params[:id].blank?

  def handle_exception e
    response.headers['Content-Type'] = 'application/json'
    response.body = { message: e.message, backtrace: e.backtrace }.to_json
  end

  def content_types_provided
    [["application/hal+json", :to_json]]
  end

  def content_types_accepted
    [["application/json", :from_json],
     ["application/hal+json", :from_json]]
  end

  def finish_request
    cors_headers.each { |k,v| response.headers[k] = v }

    response.headers['Content-Type'] = 'application/hal+json'
    if request.headers[:origin]
      response.headers['Access-Control-Allow-Origin'] = request.headers[:origin]
    end
  end

  protected

  def cors_headers
    {
     'Access-Control-Allow-Methods' => allowed_methods,
     'Allow' => allowed_methods,
     'Access-Control-Allow-Headers' => 'Origin, Content-Type, Accept', # Authorization
     'Access-Control-Allow-Credentials' => 'true'
    }
  end

  def params
    data = if request.body.to_s.present?
      JSON.parse(request.body.to_s).merge(request.path_info)
    else
      request.path_info
    end
    data.with_indifferent_access
  end

end
