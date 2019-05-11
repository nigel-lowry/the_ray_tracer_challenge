class Canvas
  attr_reader :width, :height

  def initialize width, height
    @width, @height = width, height
    @array = Array.new(height) { Array.new(width) { Color.new(0, 0, 0) } }
  end

  def to_a
    @array.flatten
  end

  def write_pixel(x, y, color)
    @array[y][x] = color
  end

  def pixel_at(x, y)
    @array[y][x]
  end
end