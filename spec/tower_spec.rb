# frozen_string_literal: true

require './tower.rb'

RSpec.describe Tower do
  describe '#within_range' do
    it 'uses euclidean distance' do
      expect(Tower.new(1,1).within_range(4,4)).to eq true
    end
  end
end
