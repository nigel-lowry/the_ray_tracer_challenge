require 'active_support/core_ext/module'
require 'intersection'

class Intersections
  attr_reader :intersections
  delegate :count, :first, :last, :to => :intersections

  def initialize *intersections
    @intersections = intersections.sort.freeze
  end

  def hit
    @intersections.find { |intersection| intersection.t > 0 }
  end
end