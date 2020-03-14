# frozen_string_literal: true

require './tower.rb'

RSpec.describe Tower do
  describe '#within_range' do
    it 'uses euclidean distance' do
      expect(Tower.new(1, 1).within_range(2, 2)).to eq true
      expect(Tower.new(1, 1).within_range(3, 3)).to eq true
      t = Tower.new(1, 1)
      t.range = 3
      expect(t.within_range(1, 4)).to eq false
      expect(Tower.new(1, 1).within_range(1, 4)).to eq true
      expect(Tower.new(1, 1).within_range(1, 5)).to eq false
      expect(Tower.new(1, 1).within_range(10, 10)).to eq false
    end
  end
end
