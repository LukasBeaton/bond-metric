require 'struct/bond'
require 'struct/spread_to_benchmark'
require 'struct/spread_to_curve'
require 'factory/bond'
require 'service/benchmark'
require 'service/report'

class BondMetric
  CORPORATE = 'corporate'
  GOVERNMENT = 'government'

  def self.generate_spread_to_benchmark(file_path)
    Service::Report.generate_spread_to_benchmark(file_path)
  end

  def self.generate_spread_to_curve(file_path)
    Service::Report.generate_spread_to_curve(file_path)
  end

  def self.print_spread_to_benchmark(file_path)
    result = generate_spread_to_benchmark(file_path)
    puts result
  end

  def self.print_spread_to_curve(file_path)
    result = generate_spread_to_curve(file_path)
    puts result
  end
end
