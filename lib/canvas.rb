class Canvas

  def initialize(width, height)
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
    raise_unless_within_bounds x, y
    @array[y][x] = color
  end

  def pixel_at(x, y)
    raise_unless_within_bounds x, y
    @array[y][x]
  end

  def to_ppm_str
    ppm_header
  end

private

  def ppm_header
    "P3\n#{width} #{height}\n255"
  end

  def raise_unless_within_bounds(x, y)
    x_in_bounds = (0...width).include? x
    y_in_bounds = (0...height).include? y

    raise 'outside bounds' unless x_in_bounds and y_in_bounds
  end
end