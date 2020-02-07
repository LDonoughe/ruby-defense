# frozen_string_literal: true

require './main.rb'
# require 'extra_print'

RSpec.describe Game do
  describe '#add_element_to_state' do
    describe 'when array doesn\t exist' do
      before do
        # var state = [[]] = '.'
      end
      it 'creates array with element' do
        g = Game.new

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

        k = Klass.new(0,0)
        g.add_element_to_state(k)

        expect(g.send(:state)['klass']).to eq [k]
      end
    end
  end
end
