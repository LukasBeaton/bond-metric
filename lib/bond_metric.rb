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
end
