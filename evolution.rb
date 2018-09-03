require_relative 'evolution/item'

class Evolution
  attr_reader :requirements

  def self.build(requirements)
    required_items = ItemSet.build(requirements)
    candy = Item.build(required: required_items.candy, type: "candy")
    extra = Item.build(required: required_items.extra, type: required_items.extra_type)
    new(required_items, candy, extra)
  end

  def initialize(requirements, candy, extra)
    @requirements = requirements
    @candy = candy
    @extra = extra
  end

  def possible?
    @candy.needed?
  end

  def calculate_progress(current_items)
    @candy.current = current_items.candy
    @extra.current = current_items.extra
  end

  def display_summary
    return unless possible?
    puts "    + you can currently evolve #{currently_possible}"

    if extras_missing?
      puts "    + find #{extras_missing} more #{@extra.type} to maximize evolutions"
    else
      puts "    + catch #{catches_needed} more pokemon to evolve another"
      puts "    + find #{@requirements.extra}(s) more #{@extra.type} to evolve another" if @extra.needed?
    end
  end

  def to_h
    requirements.to_h
  end

  def currently_possible
    [@candy.possible_evolutions, @extra.possible_evolutions].min
  end

  private

  def catches_needed
    (@candy.needed / 4.0).ceil # 4 candy per catch
  end

  def extras_missing?
    @extra.needed? && (extras_missing > 0)
  end

  def extras_missing
    (@candy.possible_evolutions - @extra.possible_evolutions) * @requirements.extra
  end
end
