module Service
  module Benchmark
    extend self

    def calculate_spread_to_benchmark(corporate_bond, government_bond)
      validate_spread_to_benchmark_params(corporate_bond, government_bond)

      return corporate_bond.basis_points - government_bond.basis_points
    end 

    def calculate_spread_to_curve(corporate_bond, government_bond_lesser, government_bond_greater)
      validate_spread_to_curve(corporate_bond, government_bond_lesser, government_bond_greater)

      x = corporate_bond.term_years
      x1 = government_bond_lesser.term_years
      x2 = government_bond_greater.term_years
      y1 = government_bond_lesser.basis_points
      y2 = government_bond_greater.basis_points
      
      y = (y1 + ((x - x1)*(y2 - y1))/(x2 - x1)).round

      return corporate_bond.basis_points - y
    end

    private

    def validate_spread_to_benchmark_params(corporate_bond, government_bond)
      raise "ERROR: Service::Benchmark#calculate_spread_to_benchmark MUST have a corporate bond as its first parameter!" if !corporate_bond.corporate?
      raise "ERROR: Service::Benchmark#calculate_spread_to_benchmark MUST have a government bond as its second parameter!"  if !government_bond.government?
    end

    def validate_spread_to_curve(corporate_bond, government_bond_lesser, government_bond_greater)
      raise "ERROR: Service::Benchmark#calculate_spread_to_curve MUST have a corporate bond as its first parameter!" if !corporate_bond.corporate?
      raise "ERROR: Service::Benchmark#calculate_spread_to_curve MUST have a government bond as its second parameter!" if !government_bond_lesser.government?
      raise "ERROR: Service::Benchmark#calculate_spread_to_curve MUST have a government bond as its third parameter!" if !government_bond_greater.government?
      raise "ERROR: Service::Benchmark#calculate_spread_to_curve MUST have a first government bond parameter with a term that is less than the second government bond parameter!" if government_bond_lesser.term_years > government_bond_greater.term_years
      raise "ERROR: Service::Benchmark#calculate_spread_to_curve MUST have a corporate bond with a term between both of the government bonds!" if corporate_bond.term_years < government_bond_lesser.term_years || corporate_bond.term_years > government_bond_greater.term_years
    end
  end
end
