require_relative 'effects'

if $0 == __FILE__
  # effect 1
  img = Effects.effect1(500, 124, 20)
  img.write 'png:outputs/effect1.png'

  img = Effects.effect1(1024, 175, 64)
  img.write 'png:outputs/effect1_2.png'
end