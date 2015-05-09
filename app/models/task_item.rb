
class TaskItem
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :completed_at, type: Time

  def id
    self._id.to_s
  end
end
