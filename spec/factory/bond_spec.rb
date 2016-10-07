require 'spec_helper'

describe Factory::Bond do
  describe '#bond' do
    it 'sets the attribute from #bond parameter and strips whitespace' do
      result = Factory::Bond.build(bond: ' nAmE    ')

      expect(result.bond).to eq('nAmE')
    end
  end

  describe '#type' do
    it 'sets the attribute from #type parameter, downcases, and strips whitespace' do
      result = Factory::Bond.build(type: ' GOVErnment  ')

      expect(result.type).to eq('government')
    end
  end
  
  describe '#term_years' do
    it 'sets the attribute from #term parameter and parses float value' do
      result = Factory::Bond.build(term: ' 18.5 yEarS  ')

      expect(result.term_years).to eq(18.5)
    end
  end

  describe '#yield' do
    it 'sets the attribute from #yield parameter as a decimal respresentation' do
      result = Factory::Bond.build(yield: ' 9.5%  ')

      expect(result.yield).to eq(0.095)
    end
  end
end
