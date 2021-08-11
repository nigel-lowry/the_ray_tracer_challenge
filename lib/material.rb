require 'color'
require 'point_light'

class Material
  attr_accessor :pattern, :color, :ambient, :diffuse, :specular, :shininess

  def initialize(pattern: nil, color: Color::WHITE, ambient: 0.1, diffuse: 0.9, specular: 0.9, shininess: 200.0)
    if pattern
      @pattern, @ambient, @diffuse, @specular, @shininess = pattern, ambient, diffuse, specular, shininess
    else
      @color, @ambient, @diffuse, @specular, @shininess = color, ambient, diffuse, specular, shininess
    end
  end

  DEFAULT = new

  def ==(other)
    self.class == other.class and self.color == other.color and self.ambient == other.ambient and self.diffuse == other.diffuse and self.specular == other.specular and self.shininess == other.shininess
  end

  def lighting light, point, eye_v, normal_v, in_shadow=false
    material_or_pattern_color = color.nil? ? pattern.stripe_at(point) : color


    effective_color = material_or_pattern_color * light.intensity
    light_v = (light.position - point).normalize
    ambient_contribution = effective_color * ambient

    light_dot_normal = Vector.dot(light_v, normal_v)

    if in_shadow or light_dot_normal < 0
      diffuse_contribution = specular_contribution = Color::BLACK
    else
      diffuse_contribution = effective_color * diffuse * light_dot_normal

      reflect_v = -light_v.reflect(normal_v)
      reflect_dot_eye = Vector.dot(reflect_v, eye_v)

      specular_contribution = if reflect_dot_eye <= 0
        Color::BLACK
      else
        factor = reflect_dot_eye ** shininess
        light.intensity * specular * factor
      end
    end

    ambient_contribution + diffuse_contribution + specular_contribution
  end
end