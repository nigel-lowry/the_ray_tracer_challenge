class Tuple
  attr_reader :x, :y, :z

  def initialize x, y, z, w
    raise_error_if_components_arent_numeric x, y, z
    raise_error_if_w_isnt_zero_or_one w

    @x, @y, @z, @w = x, y, z, w
  end

  def point?
    @w == 1.0
  end

  def vector?
    @w == 0.0
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