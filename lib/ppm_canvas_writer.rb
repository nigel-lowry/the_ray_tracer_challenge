class CanvasWriter
  def initialize canvas
    @canvas = canvas
  end

  def to_s
    ppm_header + pixel_data
  end

private

  def ppm_header
    "P3\n#{@canvas.width} #{@canvas.height}\n255"
  end

  def pixel_data
    ""
  end
end