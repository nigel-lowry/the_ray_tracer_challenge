require 'tuple'

class Point < Tuple
  def initialize x, y, z
    super(x, y, z, 1.0)
  end
end