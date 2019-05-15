require 'active_support/core_ext/module'
require 'tuple'
require 'factory'

class Vector
  attr_reader :tuple
  delegate :x, :y, :z, :w, :to => :tuple

  def initialize x, y, z
    @tuple = Tuple.new_vector(x, y, z)
  end

  def magnitude
    Math.sqrt(x ** 2 + y ** 2 + z ** 2)
  end

  def normalize
    abs = magnitude
    Vector.new(x / abs, y / abs, z / abs)
  end

  def unit_vector?
    magnitude == 1.0
  end

  def self.dot a, b
    a.x * b.x + a.y * b.y + a.z * b.z
  end

  def self.cross a, b
    Vector.new(a.y * b.z - a.z * b.y,
               a.z * b.x - a.x * b.z,
               a.x * b.y - a.y * b.x)
  end

  def +(other)
    Factory.create tuple + other
  end

  def -(other)
    Factory.create tuple - other
  end

  def -@
    Factory.create -tuple
  end

  def ==(other)
    self.class == other.class and tuple == other.tuple
  end
end