class Factory
  def self.create tuple
    case tuple.w
    when 1.0
      Point.new(tuple.x, tuple.y, tuple.z)
    else
      raise 'neither a point nor a vector'
    end
  end
end