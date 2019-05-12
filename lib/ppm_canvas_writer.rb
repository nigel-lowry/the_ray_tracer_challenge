class CanvasWriter
  MAXIMUM_COLOR_VALUE = 255
  MAXIMUM_LINE_LENGTH = 70

  def initialize canvas
    @canvas = canvas
  end

  def to_s
    "#{ppm_header}#{pixel_data}\n"
  end

private

  def ppm_header
    "P3\n#{@canvas.width} #{@canvas.height}\n#{MAXIMUM_COLOR_VALUE}\n"
  end

  def pixel_data
    rows = []
    @canvas.to_a.each_slice(@canvas.width) { |row_array| rows << row_array.collect { |color| color.to_s_ppm(MAXIMUM_COLOR_VALUE) }.join(' ') }

    rows.collect! do |row|
      split_row_string_into_array(row).flatten
    end

    rows.join "\n"
  end

  def split_row_string_into_array row
    if row.length <= MAXIMUM_LINE_LENGTH
      [row]
    else
      first_chunk = row[0, MAXIMUM_LINE_LENGTH]
      everything_after_first_chunk = row[MAXIMUM_LINE_LENGTH..-1]
      partitioned_first_chunk = first_chunk.rpartition ' '
      head, tail = partitioned_first_chunk.first, partitioned_first_chunk.last
      [head, split_row_string_into_array("#{tail}#{everything_after_first_chunk}")]
    end
  end
end