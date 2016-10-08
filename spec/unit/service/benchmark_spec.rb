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
      
      it 'can calulate a negative spread' do
        @C1.basis_points = 320
        @G1.basis_points = 480
        @G2.basis_points = 370

        result = Service::Benchmark.calculate_spread_to_curve(@C1, @G1, @G2)

        expect(result).to eq(-122)
      end
    end

    context 'failure' do
      before do
        @C2 = Struct::Bond.new('C2', 'corporate', 10.1, 510)
        @G3 = Struct::Bond.new('G3', 'government', 9.5, 375)
      end
      
      it 'must have a corporate bond as the first parameter' do
        expect{
          Service::Benchmark.calculate_spread_to_curve(@G3, @G1, @G2)
        }.to raise_error("ERROR: Service::Benchmark#calculate_spread_to_curve MUST have a corporate bond as its first parameter!")        
      end
      
      it 'must have a government bond as the second parameter' do
        expect{
          Service::Benchmark.calculate_spread_to_curve(@C1, @C2, @G2)
        }.to raise_error("ERROR: Service::Benchmark#calculate_spread_to_curve MUST have a government bond as its second parameter!")        
      end
      
      it 'must have a government bond as the third parameter' do
        expect{
          Service::Benchmark.calculate_spread_to_curve(@C1, @G1, @C2)
        }.to raise_error("ERROR: Service::Benchmark#calculate_spread_to_curve MUST have a government bond as its third parameter!")        
      end

      it 'must have a first government bond with shorter term than the second government bond' do
        @G1.term_years = 13

        expect{
          Service::Benchmark.calculate_spread_to_curve(@C1, @G1, @G2)
        }.to raise_error("ERROR: Service::Benchmark#calculate_spread_to_curve MUST have a first government bond parameter with a term that is less than the second government bond parameter!")        
      end

      it 'must have a corporate bond with a term in between the government bonds' do
        @C1.term_years = 13
        
        expect{
          Service::Benchmark.calculate_spread_to_curve(@C1, @G1, @G2)
        }.to raise_error("ERROR: Service::Benchmark#calculate_spread_to_curve MUST have a corporate bond with a term between both of the government bonds!")        
      end
    end
  end
end
