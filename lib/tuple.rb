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
    @w == 1.0
  end

  def vector?
    @w == 0.0
  end

  def neither_a_point_nor_a_vector?
    not(point? or vector?)
  end

  def +(other)
    Factory.create(Tuple.new(self.x + other.x, self.y + other.y, self.z + other.z, self.w + other.w))
  end

  def -(other)
    Factory.create(Tuple.new(self.x - other.x, self.y - other.y, self.z - other.z, self.w - other.w))
  end

  def *(scalar)
    Tuple.new(self.x * scalar, self.y * scalar, self.z * scalar, self.w * scalar)
  end

  def /(divisor)
    Tuple.new(self.x / divisor, self.y / divisor, self.z / divisor, self.w / divisor)
  end

  def -@
    Factory.create(Tuple.new(-self.x, -self.y, -self.z, -self.w))
  end

  def ==(other)
    self.x == other.x and self.y == other.y and self.z == other.z and self.w == other.w
  end

private

  def raise_error_unless_numeric x, y, z, w
    raise 'x must be a number' unless x.is_a? Numeric
    raise 'y must be a number' unless y.is_a? Numeric
    raise 'z must be a number' unless z.is_a? Numeric
    raise 'w must be a number' unless w.is_a? Numeric
  end
end