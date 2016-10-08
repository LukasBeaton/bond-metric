require 'spec_helper'

describe Service::Benchmark do
  describe '#calculate_spread_to_benchmark' do
    context 'success' do
      it 'can calculate a positive spread'
      it 'can calulate a negative spread'
    end

    context 'failure' do
      it 'must have a corporate bond as the first parameter'
      it 'must have a government bond as the second parameter'
    end
  end
end
