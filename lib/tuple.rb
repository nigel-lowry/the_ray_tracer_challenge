class Tuple
  attr_reader :x, :y, :z, :w

  POINT = 1.0
  VECTOR = 0.0

  def self.new_point x, y, z
    self.new(x, y, z, POINT)
  end

  def self.new_vector x, y, z
    self.new(x, y, z, VECTOR)
  end

  def initialize x, y, z, w
    raise_error_unless_numeric x, y, z, w

    @x, @y, @z, @w = x.to_f, y.to_f, z.to_f, w.to_f
  end

  def point?
    w == POINT
  end

  def vector?
    w == VECTOR
  end

  def neither_a_point_nor_a_vector?
    not(point? or vector?)
  end

  def +(other)
    Tuple.new(x + other.x, y + other.y, z + other.z, w + other.w)
  end

  def -(other)
    Tuple.new(x - other.x, y - other.y, z - other.z, w - other.w)
  end

  def *(scalar)
    Tuple.new(x * scalar, y * scalar, z * scalar, w * scalar)
  end

  def /(divisor)
    Tuple.new(x / divisor, y / divisor, z / divisor, w / divisor)
  end

  def -@
    Tuple.new(-x, -y, -z, -w)
  end

  def ==(other)
    self.class == other.class and x == other.x and y == other.y and z == other.z and w == other.w
  end

private

  def raise_error_unless_numeric x, y, z, w
    raise 'x must be a number' unless x.is_a? Numeric
    raise 'y must be a number' unless y.is_a? Numeric
    raise 'z must be a number' unless z.is_a? Numeric
    raise 'w must be a number' unless w.is_a? Numeric
  end
end