# frozen_string_literal: true

require 'spec_helper'

class Dummy
  include GitStats::Inspector

  def ivars_to_be_filtered
    [:@password]
  end
end

describe GitStats::Inspector do
  let(:dummy) { Dummy.new }

  describe '#to_s' do
    context 'when the object has no instance variables' do
      it 'returns only a class name' do
        expect(dummy.to_s).to eq %(#<Dummy>)
      end
    end

    context 'when the object has String instance variables' do
      it 'returns a class name, names of instance variables, and their values enclosed in double quotes' do
        dummy.instance_variable_set(:@name, 'John Doe')
        expect(dummy.to_s).to eq %(#<Dummy @name="John Doe">)
      end
    end

    context 'when the object has non-String instance variables' do
      it 'returns a class name and names and values of instance variables' do
        dummy.instance_variable_set(:@count, 1)
        dummy.instance_variable_set(:@created_at, Time.parse('2014-03-21 14:11:46 +0100'))
        expect(dummy.to_s).to eq %(#<Dummy @count=1, @created_at=2014-03-21 14:11:46 +0100>)
      end
    end

    context 'when the object has nil instance variables' do
      it 'returns a class name and names and values of instance variables' do
        dummy.instance_variable_set(:@unused, nil)
        expect(dummy.to_s).to eq %(#<Dummy @unused=nil>)
      end
    end

    context 'when the object has false instance variables' do
      it 'returns a class name and names and values of instance variables' do
        dummy.instance_variable_set(:@flag, false)
        expect(dummy.to_s).to eq %(#<Dummy @flag=false>)
      end
    end

    context 'when the object has instance variables that are not defined in #ivars_to_be_displayed' do
      it 'returns only a class name' do
        allow(dummy).to receive(:ivars_to_be_displayed).and_return([])
        dummy.instance_variable_set(:@age, 20)
        expect(dummy.to_s).to eq %(#<Dummy>)
      end
    end

    context 'when the object does not have instance variables defined in #ivars_to_be_displayed' do
      it 'returns only a class name' do
        allow(dummy).to receive(:ivars_to_be_displayed).and_return([:@name])
        expect(dummy.to_s).to eq %(#<Dummy>)
      end
    end

    context 'when the object has instance variables defined in #ivars_to_be_filtered' do
      it 'returns a class name and names and filtered values of instance variables' do
        dummy.instance_variable_set(:@password, 'password')
        expect(dummy.to_s).to eq %(#<Dummy @password=...>)
      end
    end
  end

  describe '#inspect' do
    it 'returns the same value with #to_s' do
      expect(dummy.inspect).to eq dummy.to_s
    end
  end

  describe '#ivars_to_be_displayed' do
    it 'returns all instance variable names' do
      dummy.instance_variable_set(:@name, 'John Doe')
      dummy.instance_variable_set(:@count, 1)
      dummy.instance_variable_set(:@created_at, Time.parse('2014-03-21 14:11:46 +0100'))
      expect(dummy.__send__(:ivars_to_be_displayed)).to match_array [:@name, :@count, :@created_at]
    end
  end
end
