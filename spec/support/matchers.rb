EPSILON = 0.00001

RSpec::Matchers.define :closely_eq do |expected|
  match do |actual|
    if composed_of_a_tuple?(expected) and composed_of_a_tuple?(actual) and same_class?(expected, actual)
      numbers_close?(actual.x, expected.x) and numbers_close?(actual.y, expected.y) and numbers_close?(actual.z, expected.z) && numbers_close?(actual.w, expected.w)
    elsif both_matrices?(expected, actual)
      return false unless expected.size == actual.size

      for row in 0...expected.data.length
        for column in 0...expected.data[0].length
          return false unless numbers_close? expected.get(row, column), actual.get(row, column)
        end
      end

      true
    else
      false
    end
  end

private 

  def composed_of_a_tuple? a
    a.respond_to? :tuple
  end

  def same_class? a, b
    a.class == b.class
  end

  def numbers_close? a, b
    (a - b).abs < EPSILON
  end

  def both_matrices? a, b
    a.class == Matrix and b.class == Matrix
  end
end