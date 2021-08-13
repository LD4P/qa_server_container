require 'rails_helper'

RSpec.describe Qa::Authorities::Wikidata do
  describe '.subauthorities' do
    let(:subauths) do
      [
        'item',
        'property',
        'lexeme',
        'form',
        'sense'
      ].freeze
    end
    it 'returns subauthorities' do
      expect(described_class.subauthorities).to eq subauths
    end
  end
end
