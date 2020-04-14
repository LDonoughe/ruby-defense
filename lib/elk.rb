# frozen_string_literal: true

require_relative './tower.rb'

class Elk
  def initialize(x, y)
    @x = x
    @y = y
    @ruby = false
    @power = 1
  end

  attr_reader :x
  attr_reader :y
  attr_reader :ruby
  attr_accessor :power

  def update_position(state, x, y)
    x_old = @x
    y_old = @y
    r = state['ruby']
    # keeping this in here instead of `attribute_accessor`s to preserve crystal pickup logic
    if x && y
      x_new = x
      y_new = y
    elsif (r.is_a? self.class) && (r != self)
      # move randomly
      coords = get_new_random_coordinates(@x, @y)
      x_new = coords[0]
      y_new = coords[1]
    elsif r == self
      # move towards right of screen
      x_new = x_old + 1
      y_new = y_old
    else
      rx = r[0].to_i
      ry = r[1].to_i
      if x_old > 10 && rx < 10
        # "charge"
        y_new = y || @y
        x_new = @ruby ? (@x + 1) : (@x - 1)
      else
        # move closer to ruby
        x_new = closer_to(x_old, rx)
        y_new = closer_to(y_old, ry)
      end
    end

    @x = x_new
    @y = y_new

    current = state[[@x, @y]]
    if current == 'R'
      @ruby = true
      state['ruby'] = self
    end
    state['tower'] = state['tower'] - [current] if current.is_a? Tower
    state[[x_old, y_old]] = '.'
    state[[@x, @y]] = self
  end

  def to_s
    return 'ë' if @ruby == true

    'e'
  end

  private

  def closer_to(old_coord, ruby_coord)
    if old_coord > ruby_coord
      old_coord - 1
    elsif old_coord == ruby_coord
      old_coord
    elsif old_coord < ruby_coord
      old_coord + 1
    end
  end

  def get_new_random_coordinates(x, y)
    x1 = x + flip
    y1 = y + flip
    if x1 < 60 && x1 > 0 && y1 < 10 && y1 > 0
      [x1, y1]
    else
      get_new_random_coordinates(x, y)
    end
  end

  def flip
    r = Random.random_number(2)
    n = nil
    n = -1 if r == 0
    n = 1 if r == 1
    !n.nil? ? n : flip
  end
end
