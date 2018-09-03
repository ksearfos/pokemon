require_relative 'evolution/item'

class Evolution
  UNKNOWN_TARGET = 'unknown'.freeze

  attr_reader :requirements, :target

  def self.build(target: UNKNOWN_TARGET, **requirements)
    required_items = ItemSet.build(requirements)
    candy = Item.build(required: required_items.candy, type: "candy")
    extra = Item.build(required: required_items.extra, type: required_items.extra_type)
    new(required_items, candy, extra, target.downcase)
  end

  def initialize(requirements, candy, extra, target)
    @requirements = requirements
    @candy = candy
    @extra = extra
    @target = target
  end

  def possible?
    @candy.needed?
  end

  def target_known?
    @target != UNKNOWN_TARGET
  end

  def calculate_progress(current_items)
    @candy.current = current_items.candy
    @extra.current = current_items.extra
  end

  def display_summary
    if extras_missing?
      puts "    + find #{extras_missing} more #{@extra.type} to maximize evolutions"
    else
      puts "    + catch #{catches_needed} more to evolve another"
      puts "    + find #{@requirements.extra}(s) more #{@extra.type} to evolve another" if @extra.needed?
    end

    puts "    + becomes #{@target}"
  end

  def to_h
    requirements.to_h.merge(target: @target)
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
