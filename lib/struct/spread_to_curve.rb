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
