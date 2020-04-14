# frozen_string_literal: true

require 'curses'

require './game.rb'

RSpec.describe Game do
  let(:status_window) { Curses::Window.new(6, 60, 0, 0) }
  let(:game_window) { Curses::Window.new(10, 60, 6, 0) }

  describe '#place_tower' do
    it 'creates a tower' do
      g = Game.new(status_window, game_window)
      towers = g.send(:state)['tower']
      expect(towers).to eq '.'

      g.place_tower(1, 1)
      state = g.send(:state)
      towers = state['tower']
      expect(towers.length).to eq 1
      expect(towers.first.is_a?(Tower)).to eq true

      expect(state[[1, 1]].to_s).to eq 'T'
    end
  end

  describe '#add_elk' do
    it 'fills columns' do
      g = Game.new(status_window, game_window)
      state = g.send(:state)
      expect(state['elk']).to eq '.'
      g.add_elk(60, 18)
      expect(state['elk'].length).to eq 18

      (1..9).each do |i|
        expect(state[[60, i]].class).to eq Elk
        expect(state[[59, i]].class).to eq Elk
        expect(state[[58, i]]).to eq '.'
      end
    end

    it 'works even unevenly' do
      g = Game.new(status_window, game_window)
      state = g.send(:state)
      expect(state['elk']).to eq '.'
      g.add_elk(60, 20)
      expect(state['elk'].length).to eq 20

      (1..9).each do |i|
        expect(state[[60, i]].class).to eq Elk
        expect(state[[59, i]].class).to eq Elk
      end
    end
  end

  describe 'ruby/crystal' do
    it 'keeps track of state' do
      g = Game.new(status_window, game_window)
      state = g.send(:state)
      expect(state['ruby']).to eq [3, 5]
    end
  end

  describe '#towers_attack' do
    let(:game) { Game.new(status_window, game_window) }

    it 'reduces elk power if they are within range of a tower' do
      state = game.send(:state)
      elk = Elk.new(1, 1)
      elk4 = Elk.new(2, 1)
      elk4.power = 4
      tower = Tower.new(1, 2)
      tower2 = Tower.new(2, 2)
      state['elk'] = [elk, elk4]
      state['tower'] = [tower, tower2]
      expect(state['elk'][0].power).to eq 1
      expect(state['elk'][1].power).to eq 4
      game.towers_attack
      expect(state['elk'].length).to eq 1
      expect(state['elk'][0].power).to eq 3
    end
  end

  describe '#add_element_to_state' do
    it 'creates array with element when it doesn\'t exist' do
      g = Game.new(status_window, game_window)

      class Klass
        def initialize(x, y)
          @x = x
          @y = y
        end

        attr_reader :x
        attr_reader :y

        def to_s
          'K'
        end
      end

      k = Klass.new(0, 0)
      g.add_element_to_state(k)

      expect(g.send(:state)['klass']).to eq [k]
    end
  end
end
