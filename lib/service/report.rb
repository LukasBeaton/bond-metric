require 'csv'

Struct.new("SpreadToBenchmark", :corporate, :government) do
  def proximity
    (corporate.term_years - government.term_years).abs
  end

  def spread
    Service::Benchmark.calculate_spread_to_benchmark(corporate, government)
  end

  def print_spread
    decimal = (spread / 100.0)
    sprintf("%.2f%", decimal)
  end
  
  def print_header
    "bond,benchmark,spread_to_benchmark"
  end

  def print_record
    "#{corporate.bond},#{government.bond},#{print_spread}"
  end  
end  

module Service
  class Report
    def initialize(file_path)
      @file_path = file_path
      @corporate_bonds = []
      @government_bonds = []
      @results = []
    end

    def self.generate_spread_to_benchmark(file_path)
      self.new(file_path).generate_spread_to_benchmark
    end
    
    def generate_spread_to_benchmark
      load_records

      @corporate_bonds.each do |corp_bond|
        result = Struct::SpreadToBenchmark.new(corp_bond, nil)  

        @government_bonds.each do |gov_bond|
          if result.government.nil?
            result.government = gov_bond
          else
            if (corp_bond.term_years - gov_bond.term_years).abs < result.proximity
              result.government = gov_bond 
            end
          end
        end

        @results << result
      end

      text_result = "#{@results.first.print_header}\n"

      @results.each do |result|
        text_result << "#{result.print_record}\n"
      end

      return text_result
    end

    private

    def load_records
      csv_text = ::File.read(@file_path)
      csv = ::CSV.new(csv_text, :headers => true, :header_converters => :symbol)
      records = csv.to_a.map {|row| row.to_hash }

      records.each do|record| 
        bond = Factory::Bond.build(record)
        
        @corporate_bonds << bond if bond.corporate?
        @government_bonds << bond if bond.government?
      end

      @corporate_bonds.sort!{|a,b| a.term_years <=> b.term_years}
      @government_bonds.sort!{|a,b| a.term_years <=> b.term_years}
    end
  end
end
