require 'active_support'

class Point
  attr_reader :tuple
  delegate :x, :y, :z, :w, :==, :+, :-, :to => :tuple

  def initialize x, y, z
    @tuple = Tuple.new_point(x, y, z)
  end
end