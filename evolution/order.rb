class Evolution
  class Order
    def self.for(pokemon)
      new(pokemon).order
    end

    def initialize(pokemon)
      @pokemon = pokemon
      @targets = pokemon.select do |poke|
        poke.evolution.target_known?
      end.map { |poke| poke.evolution.target }
    end

    def order
      (knowable_order + @pokemon).uniq
    end

    private

    def base_kind
      @pokemon.find { |poke| !@targets.include?(poke.name) && poke.evolution.target_known? } ||
        @pokemon.first
    end

    def find_target(pokemon)
      @pokemon.find { |poke| poke.name == pokemon.evolution.target }
    end

    def knowable_order
      list = [base_kind]

      loop do
        break if !list.last.evolution.target_known?

        target = find_target(list.last)
        break unless target

        list << find_target(list.last)
      end

      list
    end
  end
end
