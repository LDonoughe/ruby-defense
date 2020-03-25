# frozen_string_literal: true

require 'curses'

require_relative './lib/game.rb'
require_relative './lib/store.rb'

Curses.init_screen
begin
  status_window = Curses::Window.new(6, 60, 0, 0)
  game_window = Curses::Window.new(10, 60, 6, 0)

  g = Game.new(status_window, game_window)
  g.display

  s = Store.new(g, status_window)

  (1..9_999_999).each do |wave|
    if g.state['score'][1] > 99
      status_window.setpos(2, 0)
      status_window.addstr g.display_points
      s.buy_phase
    end
    status_window.setpos(0, 0)
    status_window.addstr("Defend the Ruby from the Elk. Wave #{wave}")
    status_window.refresh
    if wave == 1
      status_window.setpos(1, 0)
      status_window.addstr 'Place Towers'
      status_window.refresh
      (1..3).each do |n|
        s.add_tower(n)
      end
    end
    status_window.clear
    status_window.setpos(0, 0)
    status_window.addstr 'Elk will now attack the ruby'
    status_window.setpos(1, 0)
    status_window.addstr "Wave #{wave}"
    status_window.setpos(2, 0)
    status_window.addstr g.display_points
    status_window.refresh
    g.add_elk(60, (wave * 5))
    g.display
    g.attack_phase
  end
rescue Failure
  status_window.clear
  status_window.setpos(0, 0)
  status_window.addstr 'Failure: Elk have captured the ruby'
  status_window.setpos(1, 0)
  status_window.addstr g.display_final_points
  status_window.setpos(2, 0)
  status_window.addstr 'Press "q" + enter to quit'
  status_window.setpos(3, 0)
  status_window.refresh
  status_window.getstr
ensure
  Curses.close_screen
  puts g.state if ARGV[0] == 'debug'
end
