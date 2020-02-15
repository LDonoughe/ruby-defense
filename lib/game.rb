# frozen_string_literal: true

require_relative './tower.rb'
require_relative './elk.rb'

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
