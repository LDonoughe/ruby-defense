# frozen_string_literal: true

require_relative './tower.rb'
require_relative './elk.rb'
require 'extra_print'

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
      display
      @state['elk'].each do |e|
        e.update_position(@state, false, false)
        if e.x == 61
          puts 'Elk Have Captured the Ruby. Game Over'
          return true
        end
      end
      display
    end
  end

  def towers_attack
    @state['tower'].each do |t|
      e = t.get_elk_within_range(@state)
      if e
        e.ruby ? @state[[e.x,e.y]] = 'R' : @state[[e.x,e.y]] = '.'
        @state['elk'] = @state['elk'] - [e]
      end
    end
  end

  def add_elk(try: 0)
    x = 60
    y = rand(1..9)
    if @state[[x,y]].is_a? Elk
      try < 5 ? (return add_elk(try: (try + 1))) : e = Elk.new(x - 1, y)
    else
      e = Elk.new(x, y)
    end
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
      (1..60).each do |x|
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
