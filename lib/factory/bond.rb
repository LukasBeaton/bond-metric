Struct.new("Bond", :bond, :type)

module Factory
  module Bond
    extend self

    def build(attrs={})
      obj = Struct::Bond.new
      obj.bond = attrs[:bond].to_s.strip
      obj.type = attrs[:type].to_s.downcase.strip
      obj
    end
  end
end
