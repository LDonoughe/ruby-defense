# frozen_string_literal: true

require 'curses'

require_relative './lib/game.rb'

Curses.init_screen
begin
  nb_lines = Curses.lines
  nb_cols = Curses.cols


  puts "Number of rows: #{nb_lines}"
  puts "Number of columns: #{nb_cols}"

  if nb_lines < 15 || nb_cols < 60
    status_window = Curses::Window.new(5,60)
    game_window = Curses::Window.new(10,60)
  else
    puts 'screen too small'
    raise ScreenSizeError
  end

  g = Game.new(game_window)
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
    (1..(wave * 5)).each do
      g.add_elk
    end
    g.display
    g.attack_phase
  end

ensure
  Curses.close_screen
end