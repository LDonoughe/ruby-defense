# frozen_string_literal: true

class Tower
  def initialize(x, y)
    @x = x
    @y = y
    @range = 5
  end

  attr_reader :x
  attr_reader :y

  def within_range(x, y)
    Math.sqrt((@x**2 - x**2) + (@y**2 - y**2)) < @range
  end

  def to_s
    'T'
  end
end
