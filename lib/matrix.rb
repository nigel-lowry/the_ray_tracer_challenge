class Matrix
  attr_reader :data

  def initialize *rows
    @data = rows
  end

  def get row, column
    @data[row][column]
  end

  def *(other)
    a = [[0, 0, 0, 0],
         [0, 0, 0, 0],
         [0, 0, 0, 0],
         [0, 0, 0, 0]]

    for row in 0..3
      for col in 0..3
        a[row][col] = get(row, 0) * other.get(0, col) +
                      get(row, 1) * other.get(1, col) +
                      get(row, 2) * other.get(2, col) +
                      get(row, 3) * other.get(3, col)
      end
    end

    Matrix.new a
  end

  def ==(other)
    @data.flatten == other.data.flatten
  end
end