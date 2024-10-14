#!/usr/bin/env ruby

def from_keeper
  keeper = Player.where("season = ?", '2024-2025-keeper')
  keeper.each do |k|
    r = Player.where(['season = ? AND name = ?', '2024-2025', k.name]).take
    unless r.nil?
      r.even_strength = k.even_strength
      r.power_play = k.power_play
      r.info = k.info
      r.color = k.color
      r.save
    end
  end
end