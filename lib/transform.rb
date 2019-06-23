require 'matrix'
require 'factory'

class Transform
  attr_reader :transformation_matrix

  def self.translation x, y, z
    new Matrix.new [[1, 0, 0, x],
                    [0, 1, 0, y],
                    [0, 0, 1, z],
                    [0, 0, 0, 1]]
  end

  def self.scaling x, y, z
    new Matrix.new [[x, 0, 0, 0],
                    [0, y, 0, 0],
                    [0, 0, z, 0],
                    [0, 0, 0, 1]]
  end

  def self.rotation_x radians
    sin, cos = Math.sin(radians), Math.cos(radians)

    new Matrix.new [[1,   0,    0, 0],
                    [0, cos, -sin, 0],
                    [0, sin,  cos, 0],
                    [0,   0,    0, 1]]
  end

  def self.rotation_y radians
    sin, cos = Math.sin(radians), Math.cos(radians)

    new Matrix.new [[ cos, 0, sin, 0],
                    [   0, 1,   0, 0],
                    [-sin, 0, cos, 0],
                    [   0, 0,   0, 1]]
  end

  def self.rotation_z radians
    sin, cos = Math.sin(radians), Math.cos(radians)

    new Matrix.new [[cos, -sin, 0, 0],
                    [sin,  cos, 0, 0],
                    [0,      0, 1, 0],
                    [0,      0, 0, 1]]
  end

  def self.shearing x_y, x_z, y_x, y_z, z_x, z_y
    new Matrix.new [[  1, x_y, x_z, 0],
                    [y_x,   1, y_z, 0],
                    [z_x, z_y,   1, 0],
                    [  0,   0,   0, 1]]
  end

  def initialize m
    @transformation_matrix = m
  end

  def *(other)
    if other.respond_to? :tuple
      Factory.create @transformation_matrix * other
    elsif other.is_a? Transform
      Transform.new(transformation_matrix * other.transformation_matrix)
    else
      raise "unknown type #{other.class}"
    end
  end

  def inverse
    Transform.new @transformation_matrix.inverse
  end

  def ==(other)
    self.class == other.class and self.transformation_matrix == other.transformation_matrix
  end
end