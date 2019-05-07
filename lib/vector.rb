class Vector
  def initialize x, y, z
    @tuple = Tuple.new(x, y, z, 0.0)
  end

  def to_tuple
    @tuple
  end
end