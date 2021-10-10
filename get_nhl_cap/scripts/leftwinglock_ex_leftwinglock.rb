#!/usr/bin/env ruby



require 'nokogiri'



teams = %W{ANA BOS BUF CAR CBJ CGY CHI COL DAL DET EDM FLA LA MIN MTL NJ NSH NYI NYR OTT PHI PHX PIT SJ STL TB TOR VAN WIN WSH}
#teams = %W{ANA}

season = 2012
player_type = 'D' # D, F
game_type = 'ALL' # 1, 3, 10, ALL
strength = 'PP'   # EV, PP, SH

teams.each do |team|
	printf("%44s\n", "-----------------------")
	printf("%44s\n", "--------- #{team} ---------")
	printf("%44s\n", "-----------------------")
	puts
	printf("%44s\n", "------ Defenders ------")
	puts
		
	player_type = 'D' # D, F
	lwl_file = "get/lwl_#{season}_#{team}_#{strength}_#{player_type}.html"
	html = Nokogiri::HTML(File.open(File.expand_path( lwl_file )))
	form = html.css('form[class = "vbform block"]')[1] # second block
	rows = form.css('table tr')
	rows[1..6].each do |row|
		td = row.css('td')
		p1 = td[0].text
		p2 = td[2].text
		pct = td[3].text
		printf("%25s   %-25s %6s\n", p1, p2, pct)
	end

	puts
	puts
	printf("%44s\n", "------ Forwards ------")
	puts

	player_type = 'F'
	lwl_file = "get/lwl_#{season}_#{team}_#{strength}_#{player_type}.html"
	html = Nokogiri::HTML(File.open(File.expand_path( lwl_file )))
	form = html.css('form[class = "vbform block"]')[1] # second block
	rows = form.css('table tr')
	rows[1..6].each do |row|
		td = row.css('td')
		p1 = td[0].text
		p2 = td[1].text
		p3 = td[2].text
		p4 = td[3].text
		pct = td[4].text
		printf("%25s %25s %25s %25s %6s\n", p1, p2, p3, p4, pct)
	end
	puts
	puts
	puts
end



__END__
