require 'transform'

class Camera
  attr_reader :hsize, :vsize, :field_of_view, :transform, :pixel_size

  def initialize hsize, vsize, field_of_view
    @hsize, @vsize, @field_of_view = hsize, vsize, field_of_view
    @transform = Transform::IDENTITY

    half_view = Math.tan(field_of_view / 2.0)
    aspect = hsize / vsize.to_f

    if aspect >= 1
      @half_width = half_view
      @half_height = half_view / aspect
    else
      @half_width = half_view * aspect
      @half_height = half_view
    end

    @pixel_size = @half_width * 2 / hsize.to_f
  end
end