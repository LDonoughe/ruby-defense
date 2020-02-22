# frozen_string_literal: true

# to make debugging easier
require 'pry'
require 'extra_print'
require_relative './lib/game.rb'

g = Game.new
g.display

# puts "Place Towers"
# g.build_phase
g.place_tower(4, 5)

puts 'Elk will now attack the ruby'

while true do
  (1..5).each do
    g.add_elk
  end
  g.display
  g.attack_phase
end