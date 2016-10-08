module Service
  module Benchmark
    extend self

    def calculate_spread_to_benchmark(corporate_bond, government_bond)
      corporate_bond.yield - government_bond.yield
    end 
  end
end
