# frozen_string_literal: true

require_relative './lib/game.rb'

g = Game.new
g.display

(1..9999999).each do |wave|
  puts "Defend the Ruby from the Elk. Wave #{wave}"
  if wave == 1
    puts "Place Towers"
    (1..3).each do |n|
      puts "Placing Tower #{n}/3, input x coordinate"
      x = gets.to_i
      puts "Placing Tower #{n}/3, input y coordinate for x = #{x}"
      y = gets.to_i
      g.place_tower(x,y)
    end
  end
  puts 'Elk will now attack the ruby'
  (1..5).each do
    g.add_elk
  end
  g.display
  g.attack_phase
end