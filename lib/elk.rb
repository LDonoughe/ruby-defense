# frozen_string_literal: true

class Elk
  def initialize(x, y)
    @x = x
    @y = y
    @ruby = false
  end

  attr_reader :x
  attr_reader :y
  attr_reader :ruby

  def update_position(state, x, y)
    x_old = @x
    y_old = @y
    if x_old == 3 && !@ruby
      x_new = x || @x
      y_new = @y > 5 ? @y - 1 : @y + 1
    else
      y_new = y || @y
      x_new = @ruby ? (x || @x + 1) : (x || @x - 1)
    end
    @x = x_new
    @y = y_new

    @ruby = true if state[[@x, @y]] == 'R'
    state[[x_old, y_old]] = '.'
    state[[@x, @y]] = self
  end

  def to_s
    return 'ë' if @ruby == true

    'e'
  end
end
