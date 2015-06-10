
class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :archived, type: Boolean
  field :completed_at, type: Time

  validates_presence_of :title, :archived

  belongs_to :task_list

  def id; _id.to_s end
  def list_id; task_list_id end
end
