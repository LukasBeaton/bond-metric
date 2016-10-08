module Service
  module Benchmark
    extend self

    def calculate_spread_to_benchmark(corporate_bond, government_bond)
      corporate_bond.basis_points - government_bond.basis_points
    end 
  end
end
