class CanvasWriter
  MAXIMUM_COLOR_VALUE = 255

  def initialize canvas
    @canvas = canvas
  end

  def to_s
    ppm_header + pixel_data
  end

private

  def ppm_header
    "P3\n#{@canvas.width} #{@canvas.height}\n#{MAXIMUM_COLOR_VALUE}"
  end

  def pixel_data
    ""
  end
end