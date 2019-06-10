require 'point'
require 'color'

class PointLight
  attr_reader :position, :intensity

  def initialize position, intensity
    @position, @intensity = position, intensity
  end
end