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
    y_new = y || @y
    x_new = if @ruby
              x || @x + 1
            else
              x || @x - 1
    end
    # Come back to this later as I don't want wins to be this easy
    return false if state[[x_new, y_new]].is_a? Tower

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
