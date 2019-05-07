class Tuple
  attr_reader :x, :y, :z, :w

  def initialize x, y, z, w
    raise_error_if_components_arent_numeric x, y, z

    @x, @y, @z, @w = x, y, z, w.to_f
  end

  def point?
    @w == 1.0
  end

  def vector?
    @w == 0.0
  end

  def +(other)
    raise 'cannot add two points' if self.point? and other.point? 
    Tuple.new(self.x + other.x, self.y + other.y, self.z + other.z, self.w + other.w)
  end

  def -(other)
    raise 'cannot subtract a point from a vector' if self.vector? and other.point?
    Tuple.new(self.x - other.x, self.y - other.y, self.z - other.z, self.w - other.w)
  end

  def *(scalar)
    Tuple.new(self.x * scalar, self.y * scalar, self.z * scalar, self.w * scalar)
  end

  def -@
    raise 'cannot negate point' if self.point?
    Tuple.new(-self.x, -self.y, -self.z, -self.w)
  end

  def ==(other)
    self.x == other.x and self.y == other.y and self.z == other.z and self.w == other.w
  end

  def to_tuple
    Tuple.new(self.x, self.y, self.z, self.w)
  end

private

  def raise_error_if_components_arent_numeric x, y, z
    raise 'x must be a number' unless x.is_a? Numeric
    raise 'y must be a number' unless y.is_a? Numeric
    raise 'z must be a number' unless z.is_a? Numeric
  end
end