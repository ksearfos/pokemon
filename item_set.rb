require_relative 'allowed_extras'

class ItemSet < Struct.new(:candy, :extra, :extra_type)
  def self.build(candy: 0, extra: 0, extra_type: '')
    new(candy.to_i, extra.to_i, AllowedExtras.parse(extra_type))
  end
end
