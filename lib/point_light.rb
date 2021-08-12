class PointLight
  attr_reader :position, :intensity

  def initialize position, intensity
    @position, @intensity = position, intensity
  end

  def ==(other)
    self.class == other.class and @position == other.position and @intensity = other.intensity
  end
end