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
    "P3\n#{@canvas.width} #{@canvas.height}\n#{MAXIMUM_COLOR_VALUE}\n"
  end

  def pixel_data
    lines = []
    @canvas.to_a.each_slice(@canvas.width) { |row_array| lines << row_array.collect { |color| color.to_s_ppm(MAXIMUM_COLOR_VALUE) }.join(' ') }
    lines.join "\n"
  end
end