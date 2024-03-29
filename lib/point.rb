require 'active_support/core_ext/module'
require 'tuple'
require 'factory'

class Point
  attr_reader :tuple
  delegate :x, :y, :z, :w, :to => :tuple

  def initialize x, y, z
    @tuple = Tuple.new_point(x, y, z)
    freeze
  end

  ORIGIN = new 0, 0, 0

  def +(other)
    Factory.create tuple + other
  end

  def -(other)
    Factory.create tuple - other
  end

  def ==(other)
    self.class == other.class and tuple == other.tuple
  end
end