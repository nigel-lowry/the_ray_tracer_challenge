require 'vector'

class Color
  attr_reader :tuple
  delegate :x, :y, :z, :w, :to => :tuple
  alias_attribute :red, :x
  alias_attribute :green, :y
  alias_attribute :blue, :z

  def initialize red, green, blue
    @tuple = Tuple.new_vector(red, green, blue)
    freeze
  end

  BLACK = new 0, 0, 0
  WHITE = new 1, 1, 1

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
    "#{component_to_ppm(red, maximum_color_value)} #{component_to_ppm(green, maximum_color_value)} #{component_to_ppm(blue, maximum_color_value)}"
  end

  def black?
    self == BLACK
  end

  def ==(other)
    self.class == other.class and self.tuple == other.tuple
  end

private

  def component_to_ppm component, maximum_color_value
    component_clamped = clamp_component component
    component_clamped_and_scaled = scale_component component_clamped, maximum_color_value
    component_clamped_and_scaled.ceil
  end

  def clamp_component component
    [0.0, component, 1.0].sort[1]
  end

  def scale_component clamped_component, maximum_color_value
    clamped_component * maximum_color_value
  end
end