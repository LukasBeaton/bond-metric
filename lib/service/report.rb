require 'csv'

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
    
    def self.generate_spread_to_curve(file_path)
      self.new(file_path).generate_spread_to_curve
    end
    
    def generate_spread_to_benchmark
      load_and_sort_records

      @corporate_bonds.each do |corp_bond|
        record = Struct::SpreadToBenchmark.new(corp_bond, nil)  

        @government_bonds.each do |gov_bond|
          if record.government.nil?
            record.government = gov_bond
          else
            if Service::Benchmark.calculate_proximity(corp_bond, gov_bond) < record.proximity
              record.government = gov_bond 
            end
          end
        end

        @results << record
      end

      results_to_csv
    end

    def generate_spread_to_curve
      load_and_sort_records
      
      @corporate_bonds.each do |corp_bond|
        record = Struct::SpreadToCurve.new(corp_bond, nil, nil)  

        index = 0
        while(index < (@government_bonds.count - 1)) do
          bond_lesser = @government_bonds[index]
          bond_greater = @government_bonds[index + 1]
          
          if corp_bond.term_years.between?(bond_lesser.term_years, bond_greater.term_years)
            record.government_lesser = bond_lesser
            record.government_greater = bond_greater

            break
          end
          
          index += 1
        end

        @results << record
      end

      results_to_csv
    end

  private

    def results_to_csv
      csv_string = CSV.generate do |csv|
        csv << @results.first.report_header
        @results.each{ |r| csv << r.report_record }
      end
      
      return csv_string
    end

    def load_and_sort_records
      begin
        csv_text = ::File.read(@file_path)
      rescue Exception => e
        raise("ERROR: There was a problem trying to open '#{@file_path}'")
      end
      
      csv = ::CSV.new(csv_text, :headers => true, :header_converters => :symbol)
      records = csv.to_a.map {|row| row.to_hash }
      line = 1 #start at 1 because of header

      records.each do|record| 
        line += 1

        bond = Factory::Bond.build(record)

        begin
          bond.valid!
        rescue Exception => e
          raise "ERROR on line #{line}: #{e.message}" 
        end
        
        @corporate_bonds << bond if bond.corporate?
        @government_bonds << bond if bond.government?
      end

      @corporate_bonds.sort!{|a,b| a.term_years <=> b.term_years}
      @government_bonds.sort!{|a,b| a.term_years <=> b.term_years}
    end
  end
end

Struct.new("SpreadToBenchmark", :corporate, :government) do
  def proximity
    Service::Benchmark.calculate_proximity(corporate, government)
  end

  def spread
    Service::Benchmark.calculate_spread_to_benchmark(corporate, government)
  end

  def print_spread
    decimal = (spread / 100.0)
    sprintf("%.2f%", decimal)
  end
  
  def report_header
    ['bond', 'benchmark', 'spread_to_benchmark']
  end

  def report_record 
    [corporate.bond, government.bond, print_spread]
  end  
end  

Struct.new("SpreadToCurve", :corporate, :government_lesser, :government_greater) do
  def spread
    Service::Benchmark.calculate_spread_to_curve(corporate, government_lesser, government_greater)
  end

  def print_spread
    decimal = (spread / 100.0)
    sprintf("%.2f%", decimal)
  end
  
  def report_header
    ['bond', 'spread_to_curve']
  end

  def report_record 
    [corporate.bond, print_spread]
  end  
end  
