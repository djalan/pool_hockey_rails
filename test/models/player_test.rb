require 'test_helper'



class PlayerTest < ActiveSupport::TestCase
  fixtures :players


  test "Player.new does not work" do
    player = Player.new
    assert player.invalid?
  end


  test "Crosby is valid" do
    player = players(:Crosby)
    assert player.valid?
  end


  test "Malkin is valid" do
    player = players(:Malkin)
    assert player.valid?
  end


  test "Some elements presence: true" do
    player = players(:Crosby)

    #fields = ['name', 'points', 'goals', 'assists', 'rank', 'games', 'nhl_points', 'nhl_goals', 'nhl_assists', 'nhl_rank', 'position', 'salary']
    
    player.name = nil
    assert player.invalid?
    player.name = 'Sid'
    assert player.valid?

    player.position = nil
    assert player.invalid?
    player.position = 'D'
    assert player.valid?

    fields = ['points', 'goals', 'assists', 'rank', 'games', 'nhl_points', 'nhl_goals', 'nhl_assists', 'nhl_rank', 'salary']
    fields.each do |field|
      player.send("#{field}=", nil)
      assert player.invalid?
      player.send("#{field}=", 1)
      assert player.valid?
    end
  end 


  test "stats, rank, salary >= 0" do
    player = players(:Crosby)

    player.points = -1
    assert player.invalid?
    #player.points = 0
    #assert player.valid?
    player.points =  1 #players(:Crosby).points
    assert player.valid?
    
    player.goals = -1
    assert player.invalid?
    player.goals = 0
    assert player.valid?
    player.goals = 1
    assert player.valid?
    
    player.assists = -1
    assert player.invalid?
    player.assists = 0
    assert player.valid?
    player.assists = 1
    assert player.valid?
    
    player.rank = -1
    assert player.invalid?
    player.rank = 0
    assert player.valid?
    player.rank = 1
    assert player.valid?
    
    player.games = -1
    assert player.invalid?
    player.games = 0
    assert player.valid?
    player.games = 1
    assert player.valid?
    
    
    player.nhl_points = -1
    assert player.invalid?
    #player.nhl_points = 0
    #assert player.valid?
    player.nhl_points = 1 #players(:Crosby).nhl_points
    assert player.valid?
    
    player.nhl_goals = -1
    assert player.invalid?
    player.nhl_goals = 0
    assert player.valid?
    player.nhl_goals = 1
    assert player.valid?
    
    player.nhl_assists = -1
    assert player.invalid?
    player.nhl_assists = 0
    assert player.valid?
    player.nhl_assists = 1
    assert player.valid?
    
    player.nhl_rank = -1
    assert player.invalid?
    player.nhl_rank = 0
    assert player.valid?
    player.nhl_rank = 1
    assert player.valid?
    
    player.points = -1
    assert player.invalid?
    player.points = 0
    assert player.valid?
    player.points = 1
    assert player.valid?
  end


  test "rank and nhl_rank are unique" do
    player = players(:Crosby)
    
    player.rank = 2
    assert player.invalid?
    player.rank = 1
    assert player.valid?

    player.nhl_rank = 2
    assert player.invalid?
    player.nhl_rank = 1
    assert player.valid?
  end


  test "position format is okay" do
    player = players(:Crosby)

    player.position = 'A'
    assert player.invalid?

    player.position = 'D'
    assert player.valid?

    player.position = 'C'
    assert player.valid?

    player.position = 'L'
    assert player.valid?

    player.position = 'R'
    assert player.valid?

    player.position = 'G'
    assert player.valid?
  end


  test "power_play and pp_last_year format is okay" do
    player = players(:Crosby)

    player.power_play = 'A'
    assert player.invalid?

    player.power_play = 'F1'
    assert player.valid?

    player.power_play = 'F2'
    assert player.valid?

    player.power_play = 'F3'
    assert player.valid?

    player.power_play = 'F4'
    assert player.valid?

    player.power_play = 'D1'
    assert player.valid?

    player.power_play = 'D2'
    assert player.valid?

    player.pp_last_year = 'A'
    assert player.invalid?

    player.pp_last_year = 'F1'
    assert player.valid?

    player.pp_last_year = 'F2'
    assert player.valid?

    player.pp_last_year = 'F3'
    assert player.valid?

    player.pp_last_year = 'F4'
    assert player.valid?

    player.pp_last_year = 'D1'
    assert player.valid?

    player.pp_last_year = 'D2'
    assert player.valid?
  end


  test "team last_team power_play pp_last_year color ALLOW_BLANK: true" do
    player = players(:Crosby)

    player.team = nil
    player.last_team = nil
    player.power_play = nil
    player.pp_last_year = nil
    player.color = nil
    assert player.valid?
  end

end
