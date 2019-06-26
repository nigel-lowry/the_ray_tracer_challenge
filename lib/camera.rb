require 'transform'

class Camera
  attr_reader :hsize, :vsize, :field_of_view, :pixel_size
  attr_accessor :transform

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

  def ray_for_pixel px, py
    xoffset = (px + 0.5) * @pixel_size
    yoffset = (py + 0.5) * @pixel_size

    world_x = @half_width - xoffset
    world_y = @half_height - yoffset

    transform_inverse = @transform.inverse

    pixel = transform_inverse * Point.new(world_x, world_y, -1)
    origin = transform_inverse * Point::ORIGIN
    direction = (pixel - origin).normalize

    Ray.new(origin, direction)
  end
end