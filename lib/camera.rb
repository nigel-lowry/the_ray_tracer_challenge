require 'transform'

class Camera
  attr_reader :hsize, :vsize, :field_of_view, :transform

  def initialize hsize, vsize, field_of_view
    @hsize, @vsize, @field_of_view = hsize, vsize, field_of_view
    @transform = Transform::IDENTITY
  end
end