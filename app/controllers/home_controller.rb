class HomeController < ApplicationController

  POINTS_DESC = 'points DESC'
  RANK_POS_ASC = 'my_rank_position ASC'

  # HELPERS
  def positions_logic(position, order)
    where = 'drafted = "no"'
    if position != ''
      where += ' AND ' + position
    end
    if params[:salary_max]
      where += ' AND salary <= ?'
    end
    where += 'AND season = ?'

    session[:return_to] = request.fullpath
    if params[:salary_max]
      flash.now[:notice] = params[:salary_max]
      return Player.where(where, params[:salary_max], @year).order(order)
    else
      return Player.where(where, @year,).order(order)
    end
  end

  # CONTROLLERS
  ## /home Get
  # def index
  #   session[:return_to] = request.fullpath
  #   @no_drafted = Player.where('drafted = "yes" AND season = ?', @year).count
  #   @players = Player.where(
  #     'drafted = "no" AND season = ?',
  #     @year,
  #   ).order(POINTS_DESC)
  # end

  def all
    @players = positions_logic('', POINTS_DESC)
  end
  
  def skaters
    @players = positions_logic('position != "G"', POINTS_DESC)
  end
  
  def wingers
    @players = positions_logic(
      '(position = "L" OR position = "R")',
      POINTS_DESC,
    )
  end
  
  def centers
    @players = positions_logic('position = "C"', POINTS_DESC)
  end
  
  def defenders
    @players = positions_logic('position = "D"', POINTS_DESC)
  end

  def goalers
    @players = positions_logic('position = "G"', POINTS_DESC)
  end
  
  ## Rank controllers
  def skaters_global
    @players = positions_logic(
      'position != "G"',
      ['my_rank_global ASC', POINTS_DESC],
    )
  end

  def skaters_rank
    @players = positions_logic(
      'position != "G"',
      [RANK_POS_ASC, POINTS_DESC],
    )
  end
  
  def wingers_rank
    @players = positions_logic(
      '(position = "L" OR position = "R")',
      [RANK_POS_ASC, POINTS_DESC],
    )
  end
  
  def centers_rank
    @players = positions_logic(
      'position = "C"',
      [RANK_POS_ASC, POINTS_DESC],
    )
  end
  
  def defenders_rank
    @players = positions_logic(
      'position = "D"',
      [RANK_POS_ASC, POINTS_DESC],
    )
  end
  
  def goalers_rank
    @players = positions_logic(
      'position = "G"',
      [RANK_POS_ASC, POINTS_DESC],
    )
  end
  
  def rank
    @list = Player.where('rank != "nil"').order('rank ASC')
  end
  
  def team
    cookies.delete(:year)
    session[:return_to] = request.fullpath
  end
  
  def alainhello
    cookies[:whoami] = 'alain'
  end

  def alainbye
    cookies.delete(:whoami)
  end

  def set_year
    cookies[:year] = params[:year]
    redirect_to :back
  end
  
  def team_roster
    session[:return_to] = request.fullpath
    @players = Player.where(
      'drafted = "no" AND team = ? AND season = ?',
      params[:team_name], @year,
    ).order(POINTS_DESC)
  end
  
  def edit_rank
  end
  
  def update_rank
    
  end
    
  def pplast
  end
  
  def standings
  end
  
  def edit
  end
  
  # GET home/pp
  def pp
    session[:return_to] = request.fullpath
  end
  
  def i
    session[:return_to] = request.fullpath
    @players = Player.limit(10)
  end
  
  def test
  end
  
  def draft
    session[:return_to] = request.fullpath
    case @year
    when '2013-2014'
      @cap = 64_300_000
      @poolers = ['Alain', 'Ben', 'Mark', 'Couv']
      @max_to_draft = 20
    when '2014-2015'
      @cap = 69_000_000
      @poolers = ['Couv', 'Ben', 'Alain', 'Mark', 'Math A']
      @max_to_draft = 20
    when '2015-2016'
      @cap = 71_400_000
      @poolers = ['Math Ally', 'Ben', 'Mark', 'Alain', 'Croto']
      @max_to_draft = 20
    when '2016-2017'
      @cap = 73_000_000
      @poolers = ['Mark', 'Alain', 'Ben', 'Math Ally']
      @max_to_draft = 20
    when '2017-2018'
      @cap = 75_000_000
      @poolers = ['Mark', 'Alain', 'Ben', 'Math Ally']
      @max_to_draft = 20
    when '2018-2019'
      @cap = 79_500_000
      @poolers = ['Math', 'Alain', 'Mark', 'Ben', 'Couv']
      @max_to_draft = 20
    when '2019-2020'
      @cap = 81_500_000
      @poolers = ['Alain', 'Mark', 'Ben', 'Math', 'Couv']
      @max_to_draft = 20          
    when '2020-2021'
      @cap = 81_500_000
      @poolers = ['Ben', 'Couv', 'Alain', 'Mark', 'Math']
      @max_to_draft = 20          
    when '2021-2022'
      @cap = 81_500_000
      @poolers = ['Math', 'Ben', 'Mark', 'Alain']
      @max_to_draft = 20          
    when '2021-2022-keeper'
      @cap = 81_500_000
      @poolers = ['Mark', 'Ben', 'Couv', 'Math', 'Alain']
      @max_to_draft = 20          
    end
    
    @total_players = Player.where('season = ?', @year).count
    @total_drafted = Player.where("drafted != 'no' AND season = ?", @year).count
    
    @nbr_drafted = {}
    @spent = {}
    @left = {}
    @average = {}
    
    @poolers.each do |person|
      @nbr_drafted[person] = Player
        .where("drafted = '#{person}' AND season = ?", @year)
        .count
      @spent[person] = Player
        .select(:salary)
        .where("drafted = '#{person}' AND season = ?", @year)
        .sum(:salary)
      @left[person] = @cap - @spent[person]
      if @nbr_drafted[person] == @max_to_draft
        @average[person] = @left[person]
      else
        @average[person] = @left[person] / (@max_to_draft - @nbr_drafted[person])
      end
    end
  end
  
  
  
  
  
=begin  
  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to home_i_path, notice: 'Player was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end
=end

=begin
  def edit_individual
    @players = Player.find(params[:player_ids])
  end

   
  def update_individual
    @players = Player.update(params[:players].keys, params[:players].values).reject { |p| p.errors.empty? }
    if @players.empty?
      flash[:notice] = "Players updated"
      redirect_to players_path
    else
      render :action => "edit_individual"
    end
  end  
=end


end
