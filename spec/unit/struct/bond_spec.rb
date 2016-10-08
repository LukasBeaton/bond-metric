require 'spec_helper'

describe Struct::Bond do
  describe '#type' do
    it 'can be corporate' do
      obj = Struct::Bond.new('Name', BondMetric::CORPORATE, 5.5, 789)

      obj.valid_type!
      expect(obj.valid_type?).to eq(true)
    end

    it 'can be government' do
      obj = Struct::Bond.new('Name', BondMetric::GOVERNMENT, 5.5, 789)

      obj.valid_type!
      expect(obj.valid_type?).to eq(true)
    end

    it 'is invalid otherwise' do
      obj = Struct::Bond.new('Name', 'garbage', 5.5, 789)

      expect(obj.valid_type?).to eq(false)
      expect{
        obj.valid_type!
      }.to raise(BondError.new("Type must be either '#{BondMetric::CORPORATE}' OR '#{BondMetric::GOVERNMENT}'"))
    end
  end

  describe '#term_years' do
    it 'is valid for a decimal greater than 0'
    it 'must be decimal'
    it 'it must be greater than 0'
  end
  
  describe '#basis_points' do
    it 'is valid for a integer greater than 0'
    it 'must be a integer'
    it 'it must be greater than 0'
  end
end
