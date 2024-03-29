
class TaskItem
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :archived, type: Boolean
  field :completed_at, type: Time

  validates_presence_of :title, :archived

  def id
    self._id.to_s
  end
end
