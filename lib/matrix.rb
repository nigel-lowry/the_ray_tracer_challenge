class Matrix
  attr_reader :data

  def initialize *rows
    @data = rows
  end

  def get row, column
    @data[row][column]
  end

  def ==(other)
    @data.flatten == other.data.flatten
  end
end