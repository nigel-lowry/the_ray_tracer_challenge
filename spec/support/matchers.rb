RSpec::Matchers.define :closely_eq do |expected|
  match { |actual| numbers_close?(actual.red, expected.red) && numbers_close?(actual.green, expected.green) && numbers_close?(actual.blue, expected.blue)}

private 

  def numbers_close? a, b
    (a - b).abs < 0.00001
  end

end