# frozen_string_literal: true

require 'curses'

require_relative './lib/game.rb'

class ScreenSizeError < StandardError
end

Curses.init_screen
begin
  status_window = Curses::Window.new(6, 60, 0, 0)
  game_window = Curses::Window.new(10, 60, 6, 0)

  g = Game.new(status_window, game_window)
  g.display

  (1..9_999_999).each do |wave|
    status_window.setpos(0, 0)
    status_window.addstr("Defend the Ruby from the Elk. Wave #{wave}")
    status_window.refresh
    if wave == 1
      status_window.setpos(1, 0)
      status_window.addstr 'Place Towers'
      status_window.refresh
      (1..3).each do |n|
        status_window.setpos(2, 0)
        status_window.addstr "Placing Tower #{n}/3, input x coordinate"
        status_window.setpos(3, 0)
        x = status_window.getstr.to_i
        status_window.setpos(4, 0)
        status_window.addstr "Placing Tower #{n}/3, input y coordinate for x = #{x}"
        status_window.setpos(5, 0)
        y = status_window.getstr.to_i
        g.place_tower(x, y)
        g.display
      end
    end
    status_window.clear
    status_window.setpos(0, 0)
    status_window.addstr 'Elk will now attack the ruby'
    status_window.setpos(1, 0)
    status_window.addstr "Wave #{wave}"
    status_window.refresh
    (1..(wave * 5)).each do
      g.add_elk
    end
    g.display
    g.attack_phase
  end
ensure
  Curses.close_screen
end
