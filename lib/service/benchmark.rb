module Service
  module Benchmark
    extend self

    def calculate_spread_to_benchmark(corporate_bond, government_bond)
      raise "ERROR: Service::Benchmark#calculate_spread_to_benchmark MUST have a corporate bond as its first parameter!" if corporate_bond.type != BondMetric::CORPORATE
      raise "ERROR: Service::Benchmark#calculate_spread_to_benchmark MUST have a government bond as its second parameter!"  if government_bond.type != BondMetric::GOVERNMENT

      return corporate_bond.basis_points - government_bond.basis_points
    end 

    def calculate_spread_to_curve(corporate_bond, government_bond_lesser, government_bond_greater)
      raise "ERROR: Service::Benchmark#calculate_spread_to_curve MUST have a corporate bond as its first parameter!" if corporate_bond.type != BondMetric::CORPORATE
      raise "ERROR: Service::Benchmark#calculate_spread_to_curve MUST have a government bond as its second parameter!" if government_bond_lesser.type != BondMetric::GOVERNMENT
      raise "ERROR: Service::Benchmark#calculate_spread_to_curve MUST have a government bond as its third parameter!" if government_bond_greater.type != BondMetric::GOVERNMENT

      x = corporate_bond.term_years
      x1 = government_bond_lesser.term_years
      x2 = government_bond_greater.term_years
      y1 = government_bond_lesser.basis_points
      y2 = government_bond_greater.basis_points
      
      y = (y1 + ((x - x1)*(y2 - y1))/(x2 - x1)).round

      return corporate_bond.basis_points - y
    end
  end
end
