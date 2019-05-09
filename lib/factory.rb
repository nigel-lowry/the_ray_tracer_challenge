class Factory
  def self.create tuple
    if tuple.point?
      Point.new(tuple.x, tuple.y, tuple.z)
    elsif tuple.vector?
      Vector.new(tuple.x, tuple.y, tuple.z)
    else
      raise 'neither a point nor a vector'
    end
  end
end