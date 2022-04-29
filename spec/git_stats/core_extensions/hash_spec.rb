# frozen_string_literal: true

require 'spec_helper'

describe Hash do
  describe '#to_key_indexed_array' do
    let!(:hash) { {1 => 'x', 2 => 1, 5 => 'a'} }

    it 'converts hash to array using keys as indexes' do
      expect(hash.to_key_indexed_array).to eq([nil, 'x', 1, nil, nil, 'a'])
    end

    context 'when not all of the keys are numbers' do
      it 'throws exception' do
        invalid_hash = {1 => 'x', 'b' => 2}
        expected_message = 'all the keys must be numbers to convert to key indexed array'
        expect { invalid_hash.to_key_indexed_array }.to raise_error(expected_message)
      end
    end

    context 'when take optional min_size parameters' do
      it 'fills array with defaults up to min_size' do
        expect(hash.to_key_indexed_array(min_size: 8)).to eq([nil, 'x', 1, nil, nil, 'a', nil, nil])
      end
    end

    context 'when take optional default parameters' do
      it 'uses default value where key is not in hash' do
        expect(hash.to_key_indexed_array(default: 0)).to eq([0, 'x', 1, 0, 0, 'a'])
      end
    end
  end

  describe '#fill_empty_days!' do
    let!(:hash) { {Date.new(2020, 11, 25) => 1, Date.new(2020, 11, 27) => 2} }

    context 'when has no elements' do
      it 'returns itself' do
        expect({}.fill_empty_days!).to eq({})
      end
    end

    context 'when not all of the keys are able to convert to date' do
      it 'throws exception' do
        invalid_hash = {Date.new(2020, 11, 25) => 1, 'a' => 2}
        expect { invalid_hash.fill_empty_days! }.to raise_error('invalid date')
      end
    end

    context 'when there is an empty between the dates' do
      it 'fills in the empty dates' do
        hash.fill_empty_days!
        expect(hash).to be_key(Date.new(2020, 11, 26))
      end

      it 'set the value of the previous date' do
        hash.fill_empty_days!
        expect(hash[Date.new(2020, 11, 26)]).to eq 1
      end
    end

    context 'when set false on aggregated parameters' do
      it 'fills in the empty dates with value zero' do
        hash.fill_empty_days!(aggregated: false)
        expect(hash[Date.new(2020, 11, 26)]).to eq 0
      end
    end
  end
end
