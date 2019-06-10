require 'color'

class Material
  attr_reader :color, :ambient, :diffuse, :specular, :shininess

  def initialize
    @color, @ambient, @diffuse, @specular, @shininess = Color::WHITE, 0.1, 0.9, 0.9, 200.0
  end

  def ==(other)
    self.class == other.class and self.color == other.color and self.ambient == other.ambient and self.diffuse == other.diffuse and self.specular == other.specular and self.shininess == other.shininess
  end
end