Struct.new("Bond", :bond, :type, :term_years, :basis_points) do
  def corporate?
    type == BondMetric::CORPORATE
  end

  def government?
    type == BondMetric::GOVERNMENT
  end

  def valid?
    valid_type? && valid_term_years? && valid_basis_points?
  end

  def valid!
    valid_type!
    valid_term_years!
    valid_basis_points!
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

  def valid_basis_points?
    basis_points.class == Fixnum && basis_points > 0
  end

  def valid_basis_points!
    return if valid_basis_points?
    raise BondError.new('Basis Points must be a Integer greater than 0')
  end
end

class BondError < StandardError 
end
