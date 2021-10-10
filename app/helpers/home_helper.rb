module HomeHelper
  
  
  
  def player_info(team, position)
    Player.where("team = '#{team}' AND power_play = '#{position}' AND drafted = 'no' AND season = ?", @year).take
    #useless cuz not external   Player.where("team = ? AND power_play = ?", team, position).take
  end
  
  
  def player_drafted(person, position)
    if position == 'W'
      Player.where("drafted = '#{person}' AND (position = 'L' OR position ='R') AND season = ?", @year)
    else
      Player.where("drafted = '#{person}' AND position = '#{position}' AND season = ?", @year)
    end
  end
  
  
  
  
end
