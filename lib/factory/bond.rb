module Factory
  module Bond
    extend self

    def build(attrs={})
      obj = Struct::Bond.new
      obj.bond = attrs[:bond].to_s.strip
      obj.type = attrs[:type].to_s.downcase.strip
      obj.term_years = attrs[:term].to_s.strip.to_f
      obj.basis_points = (attrs[:yield].to_s.to_f * 100).round
      obj
    end
  end
end

Struct.new("Bond", :bond, :type, :term_years, :basis_points) do
  def corporate?
    type == BondMetric::CORPORATE
  end

  def government?
    type == BondMetric::GOVERNMENT
  end

  def valid_type?
    corporate? || government?
  end

  def valid_type!
    return if valid_type?
    raise BondError.new("Type must be either 'corporate' OR 'government'")
  end

  def valid_term_years?
    term_years.class == Float && term_years > 0
  end

  def valid_term_years!
    return if valid_term_years?
    raise BondError.new('Term Years must be a Float greater than 0')
  end
end

class BondError < StandardError 
end
