require 'spec_helper'

describe BondMetric do
  it 'has a wrapper for Service::Report#generate_spread_to_benchmark' do
    expect(Service::Report).to receive(:generate_spread_to_benchmark).with('File Path')

    BondMetric.generate_spread_to_benchmark('File Path')
  end

  it 'has a wrapper for Service::Report#generate_spread_to_curve' do
    expect(Service::Report).to receive(:generate_spread_to_curve).with('File Path')

    BondMetric.generate_spread_to_curve('File Path')
  end
end
