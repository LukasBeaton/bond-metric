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
      }.to raise_error(BondError, "Type must be either 'corporate' OR 'government'")
    end
  end

  describe '#term_years' do
    it 'is valid for a decimal greater than 0' do
      obj = Struct::Bond.new('Name', BondMetric::CORPORATE, 5.5, 789)

      obj.valid_term_years!
      expect(obj.valid_term_years?).to eq(true)
    end

    it 'must be float' do
      obj = Struct::Bond.new('Name', BondMetric::CORPORATE, '5.5', 789)

      expect(obj.valid_term_years?).to eq(false)
      expect{
        obj.valid_term_years!
      }.to raise_error(BondError, 'Term Years must be a Float greater than 0')
    end
    
    it 'it must be greater than 0' do
      obj = Struct::Bond.new('Name', BondMetric::CORPORATE, 0.0, 789)

      expect(obj.valid_term_years?).to eq(false)
      expect{
        obj.valid_term_years!
      }.to raise_error(BondError, 'Term Years must be a Float greater than 0')
    end
  end
  
  describe '#basis_points' do
    it 'is valid for a integer greater than 0' do
      obj = Struct::Bond.new('Name', BondMetric::CORPORATE, 5.5, 789)

      obj.valid_basis_points!
      expect(obj.valid_basis_points?).to eq(true)
    end

    it 'must be a integer' do
      obj = Struct::Bond.new('Name', BondMetric::CORPORATE, 5.5, '789')

      expect(obj.valid_basis_points?).to eq(false)
      expect{
        obj.valid_basis_points!
      }.to raise_error(BondError, 'Basis Points must be a Integer greater than 0')
    end
    
    it 'it must be greater than 0' do
      obj = Struct::Bond.new('Name', BondMetric::CORPORATE, '5.5', 0)

      expect(obj.valid_basis_points?).to eq(false)
      expect{
        obj.valid_basis_points!
      }.to raise_error(BondError, 'Basis Points must be a Integer greater than 0')
    end
  end

  describe '#valid?' do
    it 'is true when all validations pass' do
      obj = Struct::Bond.new('Name', BondMetric::CORPORATE, 5.5, 789)

      expect(obj.valid?).to eq(true)
    end

    it 'is false otherwise' do
      bad_type = Struct::Bond.new('Name', 'garbage', 5.5, 789)
      expect(bad_type.valid?).to eq(false)

      bad_term_years = Struct::Bond.new('Name', BondMetric::CORPORATE, '5.5', 789)
      expect(bad_term_years.valid?).to eq(false)

      bad_basis_points = Struct::Bond.new('Name', BondMetric::CORPORATE, 5.5, '789')
      expect(bad_basis_points.valid?).to eq(false)
    end
  end

  describe '#valid!' do
    it 'works when all validations pass' do
      obj = Struct::Bond.new('Name', BondMetric::CORPORATE, 5.5, 789)

      obj.valid!
    end
    
    it 'explodes otherwise' do
      bad_type = Struct::Bond.new('Name', 'garbage', 5.5, 789)
      expect{bad_type.valid!}.to raise_error(BondError)

      bad_term_years = Struct::Bond.new('Name', BondMetric::CORPORATE, '5.5', 789)
      expect{bad_term_years.valid!}.to raise_error(BondError)

      bad_basis_points = Struct::Bond.new('Name', BondMetric::CORPORATE, 5.5, '789')
      expect{bad_basis_points.valid!}.to raise_error(BondError)
    end
  end
end
