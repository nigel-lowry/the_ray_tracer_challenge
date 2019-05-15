require 'active_support/core_ext/object'
require 'tuple'

class Matrix
  attr_reader :data

  def initialize two_dimensional_array
    row_count = two_dimensional_array.length
    column_count = two_dimensional_array[0].length # assumes square, populated array
    raise "only accepts 2x2, 3x3, 4x4: #{two_dimensional_array}" unless row_count == column_count and [2, 3, 4].include?(row_count)
    
    copy = Array.new(row_count) { Array.new(column_count) }

    for row in 0...two_dimensional_array.length
      for col in 0...two_dimensional_array[0].length
        copy[row][col] = two_dimensional_array[row][col].to_f
      end
    end

    @data = copy
  end

  IDENTITY_4X4 = self.new [[1, 0, 0, 0],
                           [0, 1, 0, 0],
                           [0, 0, 1, 0],
                           [0, 0, 0, 1]]

  def get row, column
    @data[row][column]
  end

  def *(other)
    if other.is_a? Matrix
      multiply_by_matrix other
    elsif other.is_a? Tuple
      multiply_by_tuple other
    elsif other.respond_to?(:tuple)
      multiply_by_tuple other.tuple
    else
      raise "unsupported type: #{other.class}"
    end
  end

  def transpose
    Matrix.new data.transpose
  end

  def invertible?
    not determinant.zero?
  end

  def inverse
    raise 'not invertible' unless invertible?

    array_copy = data.deep_dup

    for row in 0...size
      for column in 0...size
        array_copy[column][row] = cofactor(row, column) / determinant
      end
    end

    Matrix.new array_copy
  end

  def determinant
    if size == 2
      a = get 0, 0
      b = get 0, 1
      c = get 1, 0
      d = get 1, 1

      a * d - b * c
    else
      det = 0

      for column in 0...size
        det += get(0, column) * cofactor(0, column)
      end

      det
    end
  end

  def size
    row_count # assuming square matrix
  end

  def cofactor row, column
    minor = minor(row, column)
    (row + column).odd? ? -minor : minor
  end

  def minor row, column
    submatrix(row, column).determinant
  end

  def submatrix row, column
    array_copy = data.deep_dup

    array_copy.delete_at row
    array_copy.each { |row| row.delete_at(column) }

    Matrix.new array_copy
  end

  def ==(other)
    @data == other.data
  end

private

  def multiply_by_matrix matrix
    size = 4
    a = Array.new(size) { Array.new(size) }

    for row in 0...size
      for col in 0...size
        a[row][col] = get(row, 0) * matrix.get(0, col) +
                      get(row, 1) * matrix.get(1, col) +
                      get(row, 2) * matrix.get(2, col) +
                      get(row, 3) * matrix.get(3, col)
      end
    end

    Matrix.new a
  end

  def multiply_by_tuple tuple
    a = Array.new(4)

    for row in 0...4
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