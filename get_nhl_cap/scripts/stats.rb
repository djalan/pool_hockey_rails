def stats(pooler)
  games = Player.where('season = ? and drafted = ?', '2020-2021', pooler).sum(:games)
  points = Player.where('season = ? and drafted = ?', '2020-2021', pooler).sum(:points)
  return [points, games, points.to_f / games]
end

['Mark', 'Couv', 'Alain', 'Ben', 'Math'].each do |p| arr = stats(p) ; puts "#{p} has #{arr[0]} points in #{arr[1]} games, avg of #{arr[2]}" end
