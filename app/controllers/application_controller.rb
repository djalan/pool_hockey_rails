class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :shared_stuff
  def shared_stuff
    @year = '2021-2022'
    
    @mode = 'draft'
    #@mode = 'prep'
    
    case @year
    when '2014-2015'
      @teams = ['Avalanche', 'Blackhawks', 'Bluejackets', 'Blues', 'Bruins', 'Canadiens', \
      'Canucks', 'Capitals', 'Coyotes', 'Devils', 'Ducks', 'Flames', 'Flyers', 'Hurricanes', \
      'Islanders', 'Jets', 'Kings', 'Lightning', 'Mapleleafs', 'Oilers', 'Panthers', 'Penguins', \
      'Predators', 'Rangers', 'Redwings', 'Sabres', 'Senators', 'Sharks', 'Stars', 'Wild']
      
    when '2015-2016'
      @teams = %W{ANA ARI BOS BUF CGY CAR CHI COL CLB DAL DET EDM FLA LAK MIN MTL NAS NJD NYI NYR OTT PHI PIT SJS STL TBL TOR VAN WAS WPG}
      
    when '2016-2017'
      @teams = %W{ANA ARI BOS BUF CGY CAR CHI COL CLB DAL DET EDM FLA LAK MIN MTL NAS NJD NYI NYR OTT PHI PIT SJS STL TBL TOR VAN WAS WPG}
      
    when '2017-2018'
      @teams = %W{ANA ARI BOS BUF CGY CAR CHI COL CLB DAL DET EDM FLA LAK MIN MTL NAS NJD NYI NYR OTT PHI PIT SJS STL TBL TOR VAN VGK WAS WPG}
      
    when '2018-2019'
      @teams = %W{ANA ARI BOS BUF CGY CAR CHI COL CLB DAL DET EDM FLA LAK MIN MTL NAS NJD NYI NYR OTT PHI PIT SJS STL TBL TOR VAN VGK WAS WPG}
      
    when '2019-2020'
      @teams = %W{ANA ARI BOS BUF CGY CAR CHI COL CLB DAL DET EDM FLA LAK MIN MTL NAS NJD NYI NYR OTT PHI PIT SJS STL TBL TOR VAN VGK WAS WPG None}   

    when '2020-2021'
      @teams = %W{ANA ARI BOS BUF CGY CAR CHI COL CLB DAL DET EDM FLA LAK MIN MTL NAS NJD NYI NYR OTT PHI PIT SJS STL TBL TOR VAN VGK WAS WPG None}   

    when '2021-2022'
      @teams = %W{ANA ARI BOS BUF CGY CAR CHI COL CLB DAL DET EDM FLA LAK MIN MTL NAS NJD NYI NYR OTT PHI PIT SEA SJS STL TBL TOR VAN VGK WAS WPG None}   
    end
  end
end
