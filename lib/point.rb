class Point
  def initialize x, y, z
    @tuple = Tuple.new(x, y, z, 1.0)
  end

  def to_tuple
    @tuple
  end
end