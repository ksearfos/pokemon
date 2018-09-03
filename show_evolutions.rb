#!/usr/bin/env ruby

require_relative 'io_helpers'
require_relative 'pokemon_adder'
require_relative 'item_set'
require_relative 'pokemon'
require_relative 'family'
require_relative 'persistence'

MAX = 10

families = Persistence.load_all
families.each { |family| family.calculate_evolutions }
all_pokemon = families.map(&:pokemon).flatten
all_pokemon.sort_by! { |poke| poke.evolutions_possible }

puts ""
all_pokemon.reverse.take(MAX).each do |poke|
  puts "#{poke.name}: can evolve #{poke.evolutions_possible} times (becomes #{poke.evolution.target})"
end
