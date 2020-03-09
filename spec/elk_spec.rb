# frozen_string_literal: true

require './elk.rb'

RSpec.describe Elk do
  describe '#update_position' do
    let(:state) { Hash.new('.')}
    let(:elk) { Elk.new(60,5)}

    before do
      state['elk'] = [elk]
      state[[3,5]] = 'R'
    end

    it 'usually goes left' do
      elk.update_position(state, false, false)
      expect(elk.x).to eq 59
      expect(elk.y).to eq 5
    end

    it 'goes right after taking the ruby' do
      elk.update_position(state, 3, 5)
      elk.update_position(state, false, false)
      expect(elk.x).to eq 4
      expect(elk.y).to eq 5
      expect(state['ruby']).to eq elk
    end
    
    it 'goes toward ruby' do
      elk.update_position(state, 3, 7)
      elk.update_position(state, false, false)
      expect(elk.x).to eq 3
      expect(elk.y).to eq 6
    end
    
    context 'when ruby is already taken' do
      it 'stays within bounds' do
        e2 = Elk.new(60, 5)
        e2.update_position(state, 3, 5)
        expect(e2.ruby).to eq true
        expect(state['ruby']).to eq e2
        elk.update_position(state, 3, 7)
        1000.times do
          elk.update_position(state, false, false)
          expect(elk.x).to be > 0
          expect(elk.x).to be < 61
          expect(elk.y).to be > 0
          expect(elk.y).to be < 10
        end
      end
    end
  end
end
