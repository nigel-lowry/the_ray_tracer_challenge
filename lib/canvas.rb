class Canvas

  def initialize width, height
    @array = Array.new(height) { Array.new(width) { Color.new(0, 0, 0) } }

    raise 'canvas has no pixels' if @array.empty?
  end

  def width
    @array[0].length
  end

  def height
    @array.length
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