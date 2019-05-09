class Color
  attr_reader :red, :green, :blue

  def initialize red, green, blue
    @red, @green, @blue = red, green, blue
  end

  def +(other)
    Color.new(red + other.red, green + other.green, blue + other.blue)
  end

  def -(other)
    Color.new(red - other.red, green - other.green, blue - other.blue)
  end

  def *(other)
    if other.is_a? Color
      Color.new(red * other.red, green * other.green, blue * other.blue)
    elsif other.is_a? Numeric
      Color.new(red * other, green * other, blue * other)
    else
      raise 'unsupported operand'
    end
  end

  def ==(other)
    red == other.red and green == other.green and blue == other.blue
  end
end