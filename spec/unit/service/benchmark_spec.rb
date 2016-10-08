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
      it 'must have a corporate bond as the first parameter' do
        g2 = Struct::Bond.new('G2', 'government', 10.3, 555)

        expect{
          Service::Benchmark.calculate_spread_to_benchmark(g2, @G1)
        }.to raise_error("ERROR: Service::Benchmark#calculate_spread_to_benchmark MUST have a corporate bond as its first parameter!")
      end

      it 'must have a government bond as the second parameter' do
        c2 = Struct::Bond.new('C2', 'corporate', 10.3, 555)

        expect{
          Service::Benchmark.calculate_spread_to_benchmark(@C1, c2)
        }.to raise_error("ERROR: Service::Benchmark#calculate_spread_to_benchmark MUST have a government bond as its second parameter!")
      end
    end
  end

  describe '#calculate_spread_to_curve' do
    before do
      @C1 = Struct::Bond.new('C1', 'corporate', 10.3, 530)
      @G1 = Struct::Bond.new('G1', 'government', 9.4, 370)
      @G2 = Struct::Bond.new('G2', 'government', 12, 480)
    end
    
    context 'success' do
      it 'can calculate a positive spread' do
        result = Service::Benchmark.calculate_spread_to_curve(@C1, @G1, @G2)

        expect(result).to eq(122)
      end
      
      it 'can calulate a negative spread'
    end

    context 'failure' do
      it 'must have a corporate bond as the first parameter'
      it 'must have a government bond as the second parameter'
      it 'must have a government bond as the third parameter'
      it 'must have a corporate bond with a term in between the government bonds'
    end
  end
end
