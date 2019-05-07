class Tuple
  attr_reader :x, :y, :z

  def initialize x, y, z, w
    raise 'x must be a number' unless x.is_a? Numeric
    raise 'y must be a number' unless y.is_a? Numeric
    raise 'z must be a number' unless z.is_a? Numeric
    
    raise 'w must be 0.0 or 1.0' unless w == 0.0 or w == 1.0
    @x, @y, @z, @w = x, y, z, w
  end

  def point?
    @w == 1.0
  end

  def vector?
    @w == 0.0
  end
end