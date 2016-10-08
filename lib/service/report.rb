require 'csv'

module Service
  class Report

    attr_accessor :results, :government_bonds

    def initialize(file_path)
      @file_path = file_path
    end

    def self.generate_spread_to_benchmark(file_path)
      self.new(file_path).generate_spread_to_benchmark
    end
    
    def generate_spread_to_benchmark
      csv_text = ::File.read(@file_path)
      csv = ::CSV.new(csv_text, :headers => true, :header_converters => :symbol)
      records = csv.to_a.map {|row| row.to_hash }

      records.each do|record| 
        bond = Factory::Bond.build(record)

        
      end
    end
  end
end
