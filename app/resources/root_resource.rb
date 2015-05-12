
class RootResource < BaseResource

  def allowed_methods
    ['GET', 'OPTIONS']
  end

  def to_json
    RootRepresenter.build.to_json
  end
end
