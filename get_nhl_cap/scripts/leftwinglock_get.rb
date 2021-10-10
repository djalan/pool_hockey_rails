#!/usr/bin/env ruby



require 'open-uri'



teams = %W{ANA BOS BUF CAR CBJ CGY CHI COL DAL DET EDM FLA LA MIN MTL NJ NSH NYI NYR OTT PHI PHX PIT SJ STL TB TOR VAN WIN WSH}

season = 2012
player_type = 'F'
game_type = 'ALL'
strength = 'PP'

teams.each do |team|
	url = "http://www.leftwinglock.com/line-combos/index.php?season=#{season}&team=#{team}&strength=#{strength}&playertype=#{player_type}&gametype=#{game_type}#A"
	save_file = "get/lwl_#{season}_#{team}_#{strength}_#{player_type}.html"
	File::open(save_file, 'w') do |f|
		f << open(url).read
	end
	#player_type = 'F'
	#url = "http://www.leftwinglock.com/line-combos/index.php?season=#{season}&team=#{team}&strength=#{strength}&playertype=#{player_type}&gametype=#{game_type}#A"
	#save_file = "get/lwl_#{season}_#{team}_#{strength}_#{player_type}.html"
	#File::open(save_file, 'w') do |f|
	#	f << open(url).read
	#end
end



__END__
