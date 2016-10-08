module Service
  module Benchmark
    extend self

    def calculate_spread_to_benchmark(corporate_bond, government_bond)
      raise "ERROR: Service::Benchmark#calculate_spread_to_benchmark MUST have a corporate bond as its first parameter!" if corporate_bond.type != BondMetric::CORPORATE
      raise "ERROR: Service::Benchmark#calculate_spread_to_benchmark MUST have a government bond as its second parameter!"  if government_bond.type != BondMetric::GOVERNMENT

      return corporate_bond.basis_points - government_bond.basis_points
    end 

    def calculate_spread_to_curve(corporate_bond, government_bond_less_term, government_bond_greater_term)
    end
  end
end
