require 'color'
require 'point_light'

class Material
  attr_accessor :color, :ambient, :diffuse, :specular, :shininess

  def initialize
    @color, @ambient, @diffuse, @specular, @shininess = Color::WHITE, 0.1, 0.9, 0.9, 200.0
  end

  def ==(other)
    self.class == other.class and self.color == other.color and self.ambient == other.ambient and self.diffuse == other.diffuse and self.specular == other.specular and self.shininess == other.shininess
  end

  def lighting light, point, eye_v, normal_v
    effective_color = color * light.intensity
    light_v = (light.position - point).normalize
    ambient_contribution = effective_color * ambient

    light_dot_normal = Vector.dot(light_v, normal_v)

    if light_dot_normal < 0
      diffuse_contribution = Color::BLACK
      specular_contribution = Color::BLACK
    else
      diffuse_contribution = effective_color * diffuse * light_dot_normal

      reflect_v = -light_v.reflect(normal_v)
      reflect_dot_eye = Vector.dot(reflect_v, eye_v)

      if reflect_dot_eye <= 0
        specular_contribution = Color::BLACK
      else
        factor = reflect_dot_eye ** shininess
        specular_contribution = light.intensity * specular * factor
      end
    end

    ambient_contribution + diffuse_contribution + specular_contribution
  end
end