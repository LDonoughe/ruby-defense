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
    # FIXME: use case statements here?
    if x_old == 3 && !@ruby
      x_new = x || @x
      y_new = @y > 5 ? @y - 1 : @y + 1
    else
      y_new = y || @y
      x_new = @ruby ? (x || @x + 1) : (x || @x - 1)
    end
    r = state['ruby']
    if (r.is_a? self.class) && (r != self)
      coords = get_new_random_coordinates(@x, @y)
      x_new = coords[0]
      y_new = coords[1]
    end
    @x = x_new
    @y = y_new

    if state[[@x, @y]] == 'R'
      @ruby = true
      state['ruby'] = self
    end
    state[[x_old, y_old]] = '.'
    state[[@x, @y]] = self
  end

  def to_s
    return 'ë' if @ruby == true

    'e'
  end

  private

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
