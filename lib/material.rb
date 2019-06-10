require 'color'

class Material
  attr_reader :color, :ambient, :diffuse, :specular, :shininess

  def initialize
    @color, @ambient, @diffuse, @specular, @shininess = Color::WHITE, 0.1, 0.9, 0.9, 200.0
  end
end