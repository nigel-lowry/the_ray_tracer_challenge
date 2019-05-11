class Canvas
  attr_reader :width, :height

  def initialize width, height
    @width, @height = width, height
    @array = Array.new(width) { Array.new(height) { Color.new(0, 0, 0) } }
  end

  def to_a
    @array.flatten
  end
end