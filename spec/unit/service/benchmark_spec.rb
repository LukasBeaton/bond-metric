require 'spec_helper'

describe Service::Benchmark do
  describe '#calculate_spread_to_benchmark' do
    before do
      @C1 = Struct::Bond.new('C1', 'corporate', 10.3, 0.053)
      @G1 = Struct::Bond.new('G1', 'government', 9.4, 0.037)
    end

    context 'success' do
      it 'can calculate a positive spread' do
        result = Service::Benchmark.calculate_spread_to_benchmark(@C1, @G1)

        expect(result).to eq(0.016)
      end
      
      it 'can calulate a negative spread' do
        @G1.yield = 0.06

        result = Service::Benchmark.calculate_spread_to_benchmark(@C1, @G1)

        expect(result).to eq(-0.007)
      end
    end

    context 'failure' do
      it 'must have a corporate bond as the first parameter'
      it 'must have a government bond as the second parameter'
    end
  end

  describe '#calculate_spread_to_curve' do
    context 'success' do
      it 'can calculate a positive spread'
      it 'can calulate a negative spread'
    end

    context 'failure' do
      it 'must have a corporate bond as the first parameter'
      it 'must have a government bond as the second parameter'
    end
  end
end
