class Matrix
  attr_reader :data

  def initialize *rows
    @data = rows
  end

  IDENTITY_4X4 = self.new [1, 0, 0, 0],
                          [0, 1, 0, 0],
                          [0, 0, 1, 0],
                          [0, 0, 0, 1]

  def get row, column
    @data[row][column]
  end

  def *(other)
    if other.is_a? Matrix
      multiply_by_matrix other
    elsif other.is_a? Tuple
      multiply_by_tuple other
    end
  end

  def transpose
    Matrix.new data.transpose
  end

  def determinant
    if row_count == 2 and column_count == 2
      a = get 0, 0
      b = get 0, 1
      c = get 1, 0
      d = get 1, 1

      a * d - b * c
    end
  end

  def submatrix row, column
    array_copy = Array.new data

    array_copy.delete_at row
    array_copy.each { |row| row.delete_at(column) }

    Matrix.new array_copy
  end

  def ==(other)
    @data.flatten == other.data.flatten
  end

private
  def multiply_by_matrix matrix
    a = [[0, 0, 0, 0],
         [0, 0, 0, 0],
         [0, 0, 0, 0],
         [0, 0, 0, 0]]

    for row in 0..3
      for col in 0..3
        a[row][col] = get(row, 0) * matrix.get(0, col) +
                      get(row, 1) * matrix.get(1, col) +
                      get(row, 2) * matrix.get(2, col) +
                      get(row, 3) * matrix.get(3, col)
      end
    end

    Matrix.new a
  end

  def multiply_by_tuple tuple
    a = [0, 0, 0, 0]

    for row in 0..3
      a[row] =  get(row, 0) * tuple.x +
                get(row, 1) * tuple.y +
                get(row, 2) * tuple.z +
                get(row, 3) * tuple.w
    end

    Tuple.new(a[0], a[1], a[2], a[3])
  end

  def row_count
    data.length
  end

  def column_count
    data[0].length
  end
end