require 'sphere'

class Intersection
  include Comparable

  attr_reader :t, :object

  def initialize t, object
    @t, @object = t, object
    freeze
  end

  def <=>(other)
    @t <=> other.t
  end

  def ==(other)
    self.class == other.class and @t == other.t and @object == other.object
  end
end