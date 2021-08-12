require 'matrix'
require 'transform'

class Transformations
  def self.view_transform from, to, up
    forward = (to - from).normalize
    upn = up.normalize
    left = Vector.cross forward, upn
    true_up = Vector.cross left, forward

    orientation = Matrix.new [[    left.x,     left.y,     left.z, 0],
                              [ true_up.x,  true_up.y,  true_up.z, 0],
                              [-forward.x, -forward.y, -forward.z, 0],
                              [         0,          0,          0, 1]]

    Transform.new(orientation) * Transform.translation(-from.x, -from.y, -from.z)
  end
end