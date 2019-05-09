class Color
  attr_reader :red, :green, :blue

  def initialize red, green, blue
    @red, @green, @blue = red, green, blue
  end

  def +(other)
    Color.new(@red + other.red, @green + other.green, @blue + other.blue)
  end

  def -(other)
    Color.new(@red - other.red, @green - other.green, @blue - other.blue)
  end

  def *(other)
    if other.is_a? Color
      Color.new(@red * other.red, @green * other.green, @blue * other.blue)
    else
      # scalar
      Color.new(@red * other, @green * other, @blue * other)
    end
  end

  def ==(other)
    # need epsilon
    self.red == other.red and self.green == other.green and self.blue == other.blue
  end
end