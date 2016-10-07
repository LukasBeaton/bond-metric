require 'spec_helper'

describe Factory::Bond do
  describe '#bond' do
    it 'sets the attribute from #bond parameter and strips whitespace' do
      result = Factory::Bond.build(bond: ' nAmE    ')

      expect(result.bond).to eq('nAmE')
    end
  end

  describe '#type' do
    it 'sets the attribute from #type parameter, downcases, and strips whitespace'
  end
  
  describe '#term_years' do
    it 'sets the attribute from #term parameter and parses numeric value'
  end

  describe '#yield' do
    it 'sets the attribute from #yield parameter as a decimal'
  end
end
