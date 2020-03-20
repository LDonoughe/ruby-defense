# frozen_string_literal: true

require './elk.rb'

RSpec.describe Elk do
  describe '#update_position' do
    let(:state) { Hash.new('.') }
    let(:elk) { Elk.new(60, 5) }

    before do
      state['elk'] = [elk]
      state[[3, 5]] = 'R'
      state['ruby'] = [3, 5]
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

    it 'only one elk can take the ruby' do
      elk2 = Elk.new(60, 5)
      elk.update_position(state, 3, 5)
      elk2.update_position(state, 3, 5)
      expect(elk.x).to eq 3
      expect(elk.y).to eq 5
      expect(elk2.x).to eq 3
      expect(elk2.y).to eq 5
      elk.update_position(state, false, false)
      elk2.update_position(state, false, false)
      expect(elk.x).to eq 4
      expect(elk.y).to eq 5
      expect(elk2.x).to be >= 2
      expect(elk2.x).to be <= 4
      expect(elk2.y).to be >= 4
      expect(elk2.y).to be <= 6
      expect(state['ruby']).to eq elk
      expect(state[[4,5]]).to eq elk
    end

    it 'goes toward ruby' do
      elk.update_position(state, 3, 7)
      elk.update_position(state, false, false)
      expect(elk.x).to eq 3
      expect(elk.y).to eq 6

      elk.update_position(state, 1, 5)
      elk.update_position(state, false, false)
      expect(elk.x).to eq 2
      expect(elk.y).to eq 5
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
