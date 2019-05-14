RSpec::Matchers.define :closely_eq do |expected|
  match { |actual| numbers_close?(actual.x, expected.x) && numbers_close?(actual.y, expected.y) && numbers_close?(actual.z, expected.z) && numbers_close?(actual.w, expected.w)}

private 

  def numbers_close? a, b
    (a - b).abs < 0.00001
  end

end

RSpec::Matchers.define :closely_eq_matrix do |expected|
  match do |actual|
    return false unless expected.size == actual.size

    for row in 0...expected.data.length
      for column in 0...expected.data[0].length
        return false unless (expected.get(row, column) - actual.get(row, column)).abs < 0.00001
      end
    end

    true
  end  
end