require 'spec_helper'

class Dummy
  include GitStats::Inspector

  def initialize
    super
    @name = 'John Doe'
    @count = 1
    @created_at = Time.parse('2014-03-21 14:11:46 +0100')
  end
end

describe GitStats::Inspector do
  let(:dummy) { Dummy.new }

  describe '#to_s' do
    it 'returns a class name and names and values of all instance variables' do
      expect(dummy.to_s).to eq %(#<Dummy @name="John Doe", @count=1, @created_at=2014-03-21 14:11:46 +0100>)
    end
  end

  describe '#inspect' do
    it 'returns the same value with #to_s' do
      expect(dummy.inspect).to eq dummy.to_s
    end
  end

  describe '#ivars_to_be_displayed' do
    it 'returns all instance variable names' do
      expect(dummy.ivars_to_be_displayed).to eq [:@name, :@count, :@created_at]
    end
  end
end
