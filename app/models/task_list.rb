
class TaskList
  include Mongoid::Document
  include Mongoid::Timestamps

  alias_method :name, :id
  field :public, type: Boolean
  has_many :tasks

  def name=(name)
    self.id = name
  end

end
