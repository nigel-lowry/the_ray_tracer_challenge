require 'matrix'
require 'factory'

class Transform
  def self.new_translation x, y, z
    new Matrix.new [[1, 0, 0, x],
                    [0, 1, 0, y],
                    [0, 0, 1, z],
                    [0, 0, 0, 1]]
  end

  def self.new_scaling x, y, z
    new Matrix.new [[x, 0, 0, 0],
                    [0, y, 0, 0],
                    [0, 0, z, 0],
                    [0, 0, 0, 1]]
  end

  def self.new_rotation_x radians
    new Matrix.new [[1,                 0,                  0, 0],
                    [0, Math.cos(radians), -Math.sin(radians), 0],
                    [0, Math.sin(radians),  Math.cos(radians), 0],
                    [0,                 0,                  0, 1]]
  end

  def self.new_rotation_y radians
    new Matrix.new [[ Math.cos(radians), 0, Math.sin(radians), 0],
                    [                 0, 1,                 0, 0],
                    [-Math.sin(radians), 0, Math.cos(radians), 0],
                    [                 0, 0,                 0, 1]]
  end

  def initialize m
    @transformation_matrix = m
  end

  def *(other)
    Factory.create @transformation_matrix * other
  end

  def inverse
    Transform.new @transformation_matrix.inverse
  end
end