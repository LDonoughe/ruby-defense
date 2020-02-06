# frozen_string_literal: true

class Game
  def initialize
    @state = Hash.new('.')
    @state[[3, 5]] = 'R'
  end

  def attack_phase
    until @state['elk'].empty?
      @state['elk'].each do |e|
        e.update_position(@state, false, false)
        display
        if e.x == 61
          puts 'Elk Have Captured the Ruby. Game Over'
          return true
        end
      end
    end
  end

  def add_elk
    e = Elk.new(60, 5)
    if @state['elk'].is_a? Array
      @state['elk'] += [e]
    else
      @state['elk'] = [e]
    end
    @state[[60, 5]] = e
  end

  def display
    a = (0..9).to_a
    puts a.join
    (1..9).each do |y|
      a = [y]
      (2..60).each do |x|
        a += [@state[[x, y]].to_s]
      end
      puts a.join
    end
  end
end

class Elk
  def initialize(x, y)
    @x = x
    @y = y
    @ruby = false
  end

  attr_reader :x
  attr_reader :ruby

  def update_position(state, x, y)
    x_old = @x
    y_old = @y
    @y = y || @y
    @x = if @ruby
           x || @x + 1
         else
           x || @x - 1
         end
    @ruby = true if state[[@x, @y]] == 'R'
    state[[x_old, y_old]] = '.'
    state[[@x, @y]] = self
  end

  def to_s
    return 'ë' if @ruby == true

    'e'
  end
end

g = Game.new
g.display

# puts "Place Towers"
# g.build_phase

puts 'Elk will now attack the ruby'

g.add_elk
g.display

g.attack_phase
