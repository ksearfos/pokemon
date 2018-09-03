#!/usr/bin/env ruby

require_relative 'io_helpers'
require_relative 'pokemon_adder'
require_relative 'item_set'
require_relative 'pokemon'
require_relative 'family'
require_relative 'persistence'

OPTIONS = {
  'view pokemon' => 'show_pokemon.rb',
  'add pokemon' => 'show_pokemon.rb',
  'show possible evolutions' => 'show_evolutions.rb',
}

menu = IOHelpers::Menu.new "Options:", OPTIONS.keys
choice = menu.choose
puts ""
system "ruby #{OPTIONS.fetch(choice)}"
