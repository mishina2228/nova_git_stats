# frozen_string_literal: true

require 'spec_helper'

describe Enumerable do
  describe '#first!' do
    context 'when contains matching elements' do
      it 'returns only one matching element' do
        expect([1, 2, 3, 4].first!(&:even?)).to eq 2
      end
    end

    context 'when contains no matching elements' do
      it 'raises a RuntimeError' do
        expect { [1, 3].first!(&:even?) }.to raise_error(RuntimeError)
      end
    end
  end
end
