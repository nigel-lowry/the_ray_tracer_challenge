require 'active_support'

class Color
  attr_reader :tuple
  delegate :x, :y, :z, :w, :to => :tuple
  alias_attribute :red, :x
  alias_attribute :green, :y
  alias_attribute :blue, :z

  def initialize red, green, blue
    @tuple = Tuple.new_vector(red, green, blue)
  end

  def +(other)
    Color.from_tuple(tuple + other)
  end

  def self.from_tuple tuple
    Color.new(tuple.x, tuple.y, tuple.z)
  end

  def -(other)
    Color.from_tuple(tuple - other)
  end

  def *(other)
    if other.is_a? Color
      Color.new(red * other.red, green * other.green, blue * other.blue)
    elsif other.is_a? Numeric
      Color.from_tuple(tuple * other)
    else
      raise 'unsupported operand'
    end
  end

  def to_s_ppm(maximum_color_value)
    red_clamped = clamp_component red
    blue_clamped = clamp_component blue
    green_clamped = clamp_component green

    red_clamped_and_scaled = red_clamped * maximum_color_value
    blue_clamped_and_scaled = blue_clamped * maximum_color_value
    green_clamped_and_scaled = green_clamped * maximum_color_value

    "%d %d %d" % [red_clamped_and_scaled.ceil, green_clamped_and_scaled.ceil, blue_clamped_and_scaled.ceil]
  end

  def black?
    x == 0 and y == 0 and z == 0
  end

  def ==(other)
    red == other.red and green == other.green and blue == other.blue
  end

private

  def clamp_component component
    if component < 0
      0.0
    elsif component > 1
      1.0
    else
      component
    end
  end
end