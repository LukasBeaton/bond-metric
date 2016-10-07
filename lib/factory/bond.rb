Struct.new("Bond", :bond, :type, :term_years)

module Factory
  module Bond
    extend self

    def build(attrs={})
      obj = Struct::Bond.new
      obj.bond = attrs[:bond].to_s.strip
      obj.type = attrs[:type].to_s.downcase.strip
      obj.term_years = attrs[:term].to_s.strip.to_f #ToDo: maybe change to strip our 'year'
      obj
    end
  end
end
