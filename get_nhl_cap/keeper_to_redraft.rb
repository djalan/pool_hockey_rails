#!/usr/bin/env ruby

# rails console
# require '/Users/alainsirois/workspace/2021_2022_capfriendly/pool/imp.rb'
# info()

def info()
  pp = Player.where("season = '2022-2023-keeper'")
  ppa = pp.to_a

  ppa.each do |k|
    r = Player.where("name = ? AND season = '2022-2023'", k.name).take
    r.color = k.color
    r.power_play = k.power_play
    r.even_strength = k.even_strength
    r.draft_year = k.draft_year
    r.contract = k.contract
    r.info = k.info
    r.save
  end 
end
