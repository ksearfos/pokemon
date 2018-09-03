#!/usr/bin/env ruby

require_relative 'io_helpers'

module PokemonAdder
  def self.new_family(name)
    family_args = {name: name}
    family_args[:current] = {}
    family_args[:current][:candy] = IOHelpers.prompt("Candy:")

    if IOHelpers.yes_no("Anything else?")
      family_args[:current][:extra_type] = IOHelpers.prompt("What is it?")
      family_args[:current][:extra] = IOHelpers.prompt("How many do you currently have?")
    end

    Family.build(family_args)
  end

  def self.new_member(family)
    pokemon_args = {}

    pokemon_args[:name] = IOHelpers.prompt("Pokemon name:")
    pokemon_args[:population] = IOHelpers.prompt("Current population:")
    pokemon_args[:evolution] = {}

    if IOHelpers.yes_no("Does #{pokemon_args[:name]} evolve?")
      pokemon_args[:evolution][:candy] = IOHelpers.prompt("Candy required to evolve:")

      extra_type = family.current.extra_type
      if extra_type && IOHelpers.yes_no("Are #{extra_type}s required to evolve?")
        pokemon_args[:evolution][:extra_type] = extra_type
        pokemon_args[:evolution][:extra] = IOHelpers.prompt("How many does it take?")
      end
    end

    pokemon_args
  end
end
