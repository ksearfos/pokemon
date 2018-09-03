class Evolution
  class Item < Struct.new(:type, :required, :current)
    def self.build(type: nil, required: 0, current: 0)
      new(type, required.to_i, current.to_i)
    end

    def needed?
      required > 0
    end

    def needed
      required - (current % required)
    end

    def possible_evolutions
      return Float::INFINITY unless required > 0
      current / required
    end
  end
end
