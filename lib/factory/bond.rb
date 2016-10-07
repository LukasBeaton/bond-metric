module Factory
  module Bond
    extend self

    def build(attrs={})
      obj = OpenStruct.new
      obj.bond = attrs[:bond].strip
      obj
    end
  end
end
