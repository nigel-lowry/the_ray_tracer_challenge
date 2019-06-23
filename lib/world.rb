class World
  attr_reader :objects, :light_source

  def initialize
    @objects = []
    @light_source = nil
  end
end