class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :shared_stuff
  before_action :block_user_agent

  def block_user_agent
    case request.path
    when '/', '/home/draft', '/home/alainhello', '/home/alainbye',
         '/home/set_year'
    else
      unless cookies[:whoami] == 'alain'
        render plain: 'forbidden', status: :forbidden
      end
    end
  end

  def shared_stuff
    # Dropdown years
    @list_years = [
      ['2015-2016'],
      ['2016-2017'],
      ['2017-2018'],
      ['2018-2019'],
      ['2019-2020'],
      ['2020-2021'],
      ['2021-2022'],
      ['2021-2022 Keeper', '2021-2022-keeper'],
      ['2022-2023'],
      ['2022-2023 Keeper', '2022-2023-keeper'],
    ]
    list_years_db_values = @list_years.map { |arr| arr.last }

    if cookies[:year] && (list_years_db_values.include? cookies[:year])
      @year = cookies[:year]
    else
      @year = '2021-2022'
    end

    # Dropdown what players
    @list_showWhatPlayers = ['All players', 'Not drafted']
    if cookies[:showWhatPlayers] && 
        (@list_showWhatPlayers.include? cookies[:showWhatPlayers])
      @showWhatPlayers = cookies[:showWhatPlayers]
    else
      @showWhatPlayers = 'All players'
    end

    # Dropdown mode
    @list_mode = [
      ['Single update', 'draft'],
      ['Multi update', 'prep'],
    ]
    list_mode_db_values = @list_mode.map { |arr| arr.last }
    if cookies[:modeDraftPrep] && (list_mode_db_values.include? cookies[:modeDraftPrep])
      @mode = cookies[:modeDraftPrep]
    else
      @mode = 'draft'
    end

    case @year
    when '2014-2015'
      @teams = [
        'Avalanche', 'Blackhawks', 'Bluejackets', 'Blues', 'Bruins',
        'Canadiens', 'Canucks', 'Capitals', 'Coyotes', 'Devils', 'Ducks',
        'Flames', 'Flyers', 'Hurricanes', 'Islanders', 'Jets', 'Kings',
        'Lightning', 'Mapleleafs', 'Oilers', 'Panthers', 'Penguins', 
        'Predators', 'Rangers', 'Redwings', 'Sabres', 'Senators', 'Sharks',
        'Stars', 'Wild'
      ]
      
    when '2016-2017', '2015-2016'
      @teams = %W{
        ANA ARI BOS BUF CGY CAR CHI COL CLB DAL DET EDM FLA LAK MIN MTL NAS
        NJD NYI NYR OTT PHI PIT SJS STL TBL TOR VAN WAS WPG
      }
      
    when '2018-2019', '2017-2018'
      @teams = %W{
        ANA ARI BOS BUF CGY CAR CHI COL CLB DAL DET EDM FLA LAK MIN MTL NAS
        NJD NYI NYR OTT PHI PIT SJS STL TBL TOR VAN VGK WAS WPG
      }
      
    when '2020-2021', '2019-2020'
      @teams = %W{
        ANA ARI BOS BUF CGY CAR CHI COL CLB DAL DET EDM FLA LAK MIN MTL NAS
        NJD NYI NYR OTT PHI PIT SJS STL TBL TOR VAN VGK WAS WPG None
      }

    when '2021-2022', '2021-2022-keeper', '2022-2023', '2022-2023-keeper'
      @teams = %W{
        ANA ARI BOS BUF CGY CAR CHI COL CLB DAL DET EDM FLA LAK MIN MTL NAS
        NJD NYI NYR OTT PHI PIT SEA SJS STL TBL TOR VAN VGK WAS WPG None
      }
    end
  end
end
