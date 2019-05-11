require 'active_support'

class Color
  attr_reader :tuple
  delegate :x, :y, :z, :w, :==, :+, :-, :*, :to => :tuple
  alias_attribute :red, :x
  alias_attribute :green, :y
  alias_attribute :blue, :z

  def initialize red, green, blue
    @tuple = Tuple.new_vector(red, green, blue)
  end

  def *(other)
    if other.is_a? Color
      # Vector.dot(tuple, other.tuple)
      Color.new(red * other.red, green * other.green, blue * other.blue)
    elsif other.is_a? Numeric
      tuple * other
    else
      raise 'unsupported operand'
    end
  end

  def ==(other)
    red == other.red and green == other.green and blue == other.blue
  end
end