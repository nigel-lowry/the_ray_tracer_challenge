require 'sphere'

class Intersection
  attr_reader :t, :object

  def initialize t, object
    @t, @object = t, object
  end
end