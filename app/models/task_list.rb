
class TaskList
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :public, type: Boolean
  has_many :tasks

end
