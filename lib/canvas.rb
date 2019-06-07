require 'color'

class Canvas

  def initialize(width, height, color = Color::BLACK )
    raise 'canvas has no pixels' if [width, height].any? &:zero?

    @array = Array.new(height) { Array.new(width) { color } }
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

private

  def raise_unless_within_bounds(x, y)
    x_in_bounds = (0...width).include? x
    y_in_bounds = (0...height).include? y

    raise 'outside bounds' unless x_in_bounds and y_in_bounds
  end
end