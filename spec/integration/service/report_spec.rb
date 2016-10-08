require 'spec_helper'

describe Service::Report do
  describe '#generate_spread_to_benchmark' do
    it 'accepts a CSV file outputs the results' do
      file_path = File.expand_path File.dirname(__FILE__)+"../../../fixtures/bonds_good.csv"
      
      results = Service::Report.generate_spread_to_benchmark(file_path)

      expect(results).to eq(<<-CSV)
bond,benchmark,spread_to_benchmark
C1,G1,1.60%
C2,G3,2.80%
CSV
    end

    it 'raises an exception when there is invalid data in the CSV file'
  end

  describe '#generate_spread_to_curve' do
    it 'accepts a CSV file outputs the results' do
      file_path = File.expand_path File.dirname(__FILE__)+"../../../fixtures/bonds_good.csv"
      
      results = Service::Report.generate_spread_to_curve(file_path)

      expect(results).to eq(<<-CSV)
bond,spread_to_curve
C1,1.22%
C2,2.98%
CSV
    end

    it 'raises an exception when there is invalid data in the CSV file'
  end
end
