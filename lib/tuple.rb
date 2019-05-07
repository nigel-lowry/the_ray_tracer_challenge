class Tuple
  attr_reader :x, :y, :z, :w

  def initialize x, y, z, w
    raise_error_if_components_arent_numeric x, y, z
    raise_error_if_w_isnt_zero_or_one w

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

  def ==(other)
    self.x == other.x and self.y == other.y and self.z == other.z and self.w == other.w
  end

private

  def raise_error_if_components_arent_numeric x, y, z
    raise 'x must be a number' unless x.is_a? Numeric
    raise 'y must be a number' unless y.is_a? Numeric
    raise 'z must be a number' unless z.is_a? Numeric
  end

  def raise_error_if_w_isnt_zero_or_one w
    raise 'w must be 0.0 or 1.0' unless [0.0, 1.0].include? w
  end
end