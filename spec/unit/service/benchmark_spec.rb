require 'spec_helper'

describe Service::Benchmark do
  describe '#calculate_spread_to_benchmark' do
    before do
      @C1 = Struct::Bond.new('C1', 'corporate', 10.3, 530)
      @G1 = Struct::Bond.new('G1', 'government', 9.4, 370)
    end

    context 'success' do
      it 'can calculate a positive spread' do
        result = Service::Benchmark.calculate_spread_to_benchmark(@C1, @G1)

        expect(result).to eq(160)
      end
      
      it 'can calulate a negative spread' do
        @G1.basis_points = 600

        result = Service::Benchmark.calculate_spread_to_benchmark(@C1, @G1)

        expect(result).to eq(-70)
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
