require 'roar/decorator'
require 'roar/json/hal'

class RootRepresenter < Roar::Decorator
  include Roar::JSON::HAL

  link :self  do; Wunderlist.uri(:root_representer, :self) end
  link :auth  do; Wunderlist.uri(:root_representer, :auth) end
  link :tasks do; Wunderlist.uri(:root_representer, :tasks) end
  link :archive do; Wunderlist.uri(:root_representer, :archive) end
  # this could replace archive later on: a archive list inside lists
  # link :lists do; Wunderlist.uri(:root_representer, :lists) end
  link :users do; Wunderlist.uri(:root_representer, :users) end

  def self.build
    new(OpenStruct.new)
  end
  
end
