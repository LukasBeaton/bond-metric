require 'spec_helper'

describe Service::Report do
  let(:good_file_path){File.expand_path File.dirname(__FILE__)+"../../../fixtures/bonds_good.csv"}
  let(:bad_file_path){File.expand_path File.dirname(__FILE__)+"../../../fixtures/bonds_bad.csv"}

  describe '#generate_spread_to_benchmark' do
    it 'accepts a CSV file outputs the results' do
      results = Service::Report.generate_spread_to_benchmark(good_file_path)

      expect(results).to eq(<<-CSV)
bond,benchmark,spread_to_benchmark
C1,G1,1.60%
C2,G3,2.80%
CSV
    end

    it 'raises an exception when there is an invalid Bond in the CSV file' do
      expect{
        Service::Report.generate_spread_to_benchmark(bad_file_path)
      }.to raise_error("ERROR on line 5: Type must be either 'corporate' OR 'government'")
    end

    it 'raises an exception when the file can not be opened' do
      expect{
        Service::Report.generate_spread_to_benchmark('/bad/path/to/file.csv')
      }.to raise_error("ERROR: There was a problem trying to open '/bad/path/to/file.csv'")
    end
  end

  describe '#generate_spread_to_curve' do
    it 'accepts a CSV file outputs the results' do
      results = Service::Report.generate_spread_to_curve(good_file_path)

      expect(results).to eq(<<-CSV)
bond,spread_to_curve
C1,1.22%
C2,2.98%
CSV
    end

    it 'raises an exception when there is invalid data in the CSV file' do
      expect{
        Service::Report.generate_spread_to_curve(bad_file_path)
      }.to raise_error("ERROR on line 5: Type must be either 'corporate' OR 'government'")
    end
    
    it 'raises an exception when the file can not be opened' do
      expect{
        Service::Report.generate_spread_to_curve('/bad/path/to/file.csv')
      }.to raise_error("ERROR: There was a problem trying to open '/bad/path/to/file.csv'")
    end
  end
end
