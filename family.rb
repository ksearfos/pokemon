require_relative 'evolution/order'

class Family
  attr_accessor :pokemon
  attr_reader :name, :current

  def self.build(name: '', current: {}, pokemon: [])
    current_items = ItemSet.build(current)
    pokemon.map! { |poke| Pokemon.build(poke) }

    new(name.downcase, current_items, pokemon)
  end

  def initialize(name, current, pokemon)
    @name = name
    @current = current
    @pokemon = pokemon
  end

  def calculate_evolutions
    @pokemon.each { |pokemon| pokemon.calculate_evolution(current) }
  end

  def display_summary
    if population == 0
      puts "You have no #{name}s at the moment."
    else
      puts "You have #{population} pokemon in the #{name} family:"

      calculate_evolutions
      Evolution::Order.for(pokemon).each do |pokemon|
        pokemon.display_summary
      end
    end
  end

  def to_h
    {
      name: name,
      pokemon: pokemon.map(&:to_h),
    }.merge(current: current.to_h)
  end

  private

  def population
    pokemon.map(&:population).reduce(&:+).to_i
  end
end
