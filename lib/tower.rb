# frozen_string_literal: true

require 'pry'

class Tower
  def initialize(x, y)
    @x = x
    @y = y
    @range = 4
  end

  attr_reader :x
  attr_reader :y
  attr_accessor :range

  def within_range(x, y)
    Math.sqrt(((@x - x)**2 + (@y - y)**2).abs) < @range
  end

  def get_elk_within_range(state)
    state['elk'].each do |elk|
      return elk if within_range(elk.x, elk.y)
    end
    false
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
