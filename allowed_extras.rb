module AllowedExtras
  TYPES = {
    'sun stone' => :sun_stone,
    'sun_stone' => :sun_stone,
    'sunstone' => :sun_stone,
    :sun_stone => :sun_stone,
    "king's rock" => :kings_rock,
    "kings rock" => :kings_rock,
    "kings_rock" => :kings_rock,
    "kingsrock" => :kings_rock,
    :king_rock => :kings_rock,
    'upgrade' => :upgrade,
    :upgrade => :upgrade,
    'metal coat' => :metal_coat,
    'metal_coat' => :metal_coat,
    'metalcoat' => :metal_coat,
    :metalcoat => :metal_coat,
    'dragon scale' => :dragon_scale,
    'dragon_scale' => :dragon_scale,
    'dragonscale' => :dragon_scale,
    :dragon_scale => :dragon_scale,
    '' => nil,
    nil => nil,
  }

  def self.parse(str)
    TYPES.fetch(str)
  end
end
