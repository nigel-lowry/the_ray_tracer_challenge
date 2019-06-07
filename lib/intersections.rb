class Intersections
  attr_reader :intersections
  delegate :count, :first, :last, :to => :intersections

  def initialize *intersections
    @intersections = intersections
  end
end