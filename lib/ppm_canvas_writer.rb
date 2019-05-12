require 'active_support'

class CanvasWriter
  MAXIMUM_COLOR_VALUE = 255
  MAXIMUM_LINE_LENGTH = 70

  def initialize canvas
    @canvas = canvas
  end

  def to_s
    ppm_header + pixel_data + "\n"
  end

private

  def ppm_header
    "P3\n#{@canvas.width} #{@canvas.height}\n#{MAXIMUM_COLOR_VALUE}\n"
  end

  def pixel_data
    rows = []
    @canvas.to_a.each_slice(@canvas.width) { |row_array| rows << row_array.collect { |color| color.to_s_ppm(MAXIMUM_COLOR_VALUE) }.join(' ') }
    rows.join "\n"
    rows.collect { |line| split(line) }
    rows.join "\n"
  end

  def split line
    if line.length > MAXIMUM_LINE_LENGTH
      if line[MAXIMUM_LINE_LENGTH - 1] == ' '
        line[MAXIMUM_LINE_LENGTH - 1] = "\n" 
      else
        partitioned_string = line.rpartition ' '
        head, tail = partitioned_string.first, partitioned_string.last
        line[head.length] = "\n"
        # split(tail) # is this being thrown away?
      end
    end
  end
end