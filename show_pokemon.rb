#!/usr/bin/env ruby

require_relative 'io_helpers'
require_relative 'pokemon_adder'
require_relative 'item_set'
require_relative 'pokemon'
require_relative 'family'
require_relative 'persistence'

name = IOHelpers.prompt("Pokemon family:")
family = Persistence.load(name) || PokemonAdder.new_family(name)

family.display_summary

add_another = IOHelpers.yes_no "Would you like to add one?"

if add_another
  pokemon_args = PokemonAdder.new_member(family)
  family.pokemon << Pokemon.build(pokemon_args)
  family.display_summary
  Persistence.save(family)
end
