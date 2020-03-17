# frozen_string_literal: true

class Store
  def initialize(game, status_window)
    @game = game
    @status_window = status_window
  end

  def buy_phase
    @status_window.setpos(0, 0)
    @status_window.addstr "Purchase Additional Tower for 100/#{@game.state['score'][1]} points? [y/n]"
    if @status_window.getstr == 'y'
      @game.purchase_tower
      add_tower
      buy_phase if @game.state['score'][1] > 99
    else
      false
    end
  end

  def add_tower(n = nil)
    @status_window.setpos(2, 0)
    if n
      @status_window.addstr "Placing Tower #{n}/3, input x coordinate"
    else
      @status_window.addstr "Placing Tower, input x coordinate"
    end
    @status_window.setpos(3, 0)
    x = @status_window.getstr.to_i
    @status_window.setpos(4, 0)
    if n
      @status_window.addstr "Placing Tower #{n}/3, input y coordinate for x = #{x}"
    else
      @status_window.addstr "Placing Tower, input y coordinate"
    end
    @status_window.setpos(5, 0)
    y = @status_window.getstr.to_i
    @game.place_tower(x, y)
    @game.display
  end
end
