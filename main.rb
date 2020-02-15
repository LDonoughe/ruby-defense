# frozen_string_literal: true

# to make debugging easier
require 'pry'
require 'extra_print'

class Game
  def initialize
    @state = Hash.new('.')
    @state[[3, 5]] = 'R'
  end

  attr_reader :state

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
    add_element_to_state(e)
  end

  def place_tower(x, y)
    t = Tower.new(x, y)
    current = @state[[x, y]]
    if current == '.'
      add_element_to_state(t)
    else
      false
    end
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

  def add_element_to_state(element)
    state_array = @state[element.class.to_s.downcase]
    if state_array.is_a? Array
      state_array += [element]
    else
      state_array = [element]
    end

    @state[element.class.to_s.downcase] = state_array
    @state[[element.x, element.y]] = element
  end
end

class Tower
  def initialize(x, y)
    @x = x
    @y = y
  end

  attr_reader :x
  attr_reader :y

  def to_s
    'T'
  end
end

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
    # eap state[[@x, @y]]
    # eap state[[x_new, y_new]].is_a? Tower
    # eap state[[@x, @y]].class
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

g = Game.new
g.display

# puts "Place Towers"
# g.build_phase
g.place_tower(4, 5)

puts 'Elk will now attack the ruby'

g.add_elk
g.display

g.attack_phase
