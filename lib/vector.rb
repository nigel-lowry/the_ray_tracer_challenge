require 'tuple'

class Vector < Tuple
  def initialize x, y, z
    super(x, y, z, 0.0)
  end

  def magnitude
    Math.sqrt(@x ** 2 + @y ** 2 + @z ** 2)
  end
end