json.array!(@players) do |player|
  json.extract! player, :name, :points, :goals, :assists, :rank, :nhl_points, :nhl_goals, :nhl_assists, :nhl_rank, :team, :last_team, :power_play, :pp_last_year, :position, :salary
  json.url player_url(player, format: :json)
end
