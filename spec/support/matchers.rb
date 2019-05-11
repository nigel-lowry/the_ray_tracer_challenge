RSpec::Matchers.define :closely_eq do |expected|
  match { |actual| numbers_close?(actual.x, expected.x) && numbers_close?(actual.y, expected.y) && numbers_close?(actual.z, expected.z) && numbers_close?(actual.w, expected.w)}

private 

  def numbers_close? a, b
    (a - b).abs < 0.00001
  end

end