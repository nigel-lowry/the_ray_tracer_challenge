class Canvas

  def initialize width, height
    raise 'canvas has no pixels' if [width, height].any? &:zero?

    @array = Array.new(height) { Array.new(width) { Color.new(0, 0, 0) } }
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
    raise 'outside bounds' unless (0...width).include? x and (0...height).include? y
    @array[y][x]
  end
end