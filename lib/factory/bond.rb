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
