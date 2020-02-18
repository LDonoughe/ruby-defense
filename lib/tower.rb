# frozen_string_literal: true

require 'pry'

class Tower
  def initialize(x, y)
    @x = x
    @y = y
    @range = 5
  end

  attr_reader :x
  attr_reader :y

  def within_range(x, y)
    # binding.pry
    Math.sqrt(((@x - x)**2 + (@y - y)**2).abs) < @range
  end

  def to_s
    'T'
  end
end
