require 'spec_helper'

describe GitStats::StatsView::View do
  let(:view) { described_class.new(nil, out_path) }

  describe '@out_path' do
    context 'when out_path is not passed' do
      let(:out_path) { nil }

      it 'raises exception' do
        expect { view }.to raise_error(TypeError)
      end
    end

    context 'when given out_path is an absolute path' do
      let(:out_path) { '/tmp' }

      it 'returns the given out_path as is' do
        expect(view.instance_variable_get(:@out_path)).to eq('/tmp')
      end
    end

    context 'when given out_path is a relative path' do
      let(:out_path) { '.' }

      it 'converts it to an absolute path' do
        expect(view.instance_variable_get(:@out_path)).to eq(Dir.pwd)
      end
    end

    context 'when given out_path includes tilde' do
      let(:out_path) { '~/../../' }

      it 'converts it to an absolute path' do
        expect(view.instance_variable_get(:@out_path)).to eq('/')
      end
    end
  end
end
