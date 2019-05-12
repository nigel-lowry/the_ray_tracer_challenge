class Matrix
  def initialize *rows
    @data = rows
  end

  def get row, column
    @data[row][column]
  end
end