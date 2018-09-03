require_relative 'evolution'

class Pokemon
  attr_reader :name, :population, :evolution

  def self.build(name: '', population: 0, evolution: {})
    evolution_requirements = Evolution.build(evolution)
    new(name.downcase, population.to_i, evolution_requirements)
  end

  def initialize(name, population, evolution)
    @name = name
    @population = population
    @evolution = evolution
  end

  def display_summary
    puts "  - #{population} #{name} (you may transfer up to #{transfers_available})"
    evolution.display_summary
  end

  def calculate_evolution(current_items)
    return unless evolves?
    evolution.calculate_progress(current_items)
  end

  def evolves?
    evolution.possible?
  end

  def evolutions_possible
    return 0 unless evolves?
    [evolution.currently_possible, evolvable_population].min
  end

  def to_h
    {
      name: name,
      population: population
    }.merge(evolution: evolution.to_h)
  end

  private

  def transfers_available
    [population - evolution.currently_possible, 0].max
  end

  def evolvable_population
    [population - 1, 0].max  # keep one unevolved pokemon
  end
end
