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
    Math.sqrt(((@x - x)**2 + (@y - y)**2).abs) < @range
  end

  def closest_elk_within_range(state)
    e = false
    (1..9).each do |y|
      (2..60).each do |x|
        a += [state[[x, y]]]
      end
    end
  end

  def xa(x)
    case x
    when x < 1
      1
    when x > 9
      9
    else
      x
    end
  end

  def ya(y)
    case y
    when y < 1
      1
    when y > 60
      60
    else
      y
    end
  end

  def to_s
    'T'
  end
end
