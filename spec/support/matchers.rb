EPSILON = 0.00001

RSpec::Matchers.define :closely_eq do |expected|
  match do |actual|
    if (expected.class == Color and actual.class == Color) || (expected.class == Point and actual.class == Point) || (expected.class == Vector and actual.class == Vector)
      numbers_close?(actual.x, expected.x) && numbers_close?(actual.y, expected.y) && numbers_close?(actual.z, expected.z) && numbers_close?(actual.w, expected.w)
    elsif expected.class == Matrix and actual.class == Matrix
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

  def numbers_close? a, b
    (a - b).abs < EPSILON
  end
end