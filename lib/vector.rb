require 'tuple'

class Vector < Tuple
  def initialize x, y, z
    super(x, y, z, 0.0)
  end
end