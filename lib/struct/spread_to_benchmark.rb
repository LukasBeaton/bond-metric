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
