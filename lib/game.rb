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
      sleep 0.2
      towers_attack
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

  def towers_attack
    @state['towers'].each do |t|
      e = t.get_elk_within_range(@state)
      if e
        @state[[e.x,e.y]] = '.'
        @state['elk'] = @state['elk'] - [e]
      end
    end
  end

  def add_elk
    x = 60
    y = rand(1..9)
    if @state[[x,y]].is_a? Elk
      add_elk
    else
      e = Elk.new(x, y)
    end
    add_element_to_state(e)
  end

  def place_tower(x, y)
    t = Tower.new(x, y)
    if @state['towers'] == '.'
      @state['towers'] = [t]
    else
      @state['towers'] += [t]
    end
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
