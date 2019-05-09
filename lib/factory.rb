class Factory
  def self.create tuple
    case tuple.w
    when 1.0
      Point.new(tuple.x, tuple.y, tuple.z)
    when 0.0
      Vector.new(tuple.x, tuple.y, tuple.z)
    else
      raise 'neither a point nor a vector'
    end
  end
end