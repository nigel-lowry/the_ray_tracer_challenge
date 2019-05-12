class Matrix
  attr_reader :data

  def initialize *rows
    @data = rows
  end

  def get row, column
    @data[row][column]
  end

  def *(other)
    if other.is_a? Matrix
      multiply_by_matrix other
    elsif other.is_a? Tuple
      a = [0, 0, 0, 0]

      for row in 0..3
        a[row] =  get(row, 0) * other.x +
                  get(row, 1) * other.y +
                  get(row, 2) * other.z +
                  get(row, 3) * other.w
      end

      Tuple.new(a[0], a[1], a[2], a[3])
    end
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
end