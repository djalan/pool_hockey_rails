class HomeController < ApplicationController

  # GET /home
  def index
    session[:return_to] = request.fullpath
    @no_drafted = Player.where('drafted = "yes" AND season = ?', @year).count
    @players = Player.where('drafted = "no" AND season = ?', @year).order('points DESC')
    
    #@search = Player.new(params[:player])
    #@players = Player.where('position = ?', @search.position)
  end
  
  
  def all
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND salary <= ? AND season = ?', params[:salary_max], @year).order('points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND season = ?', @year).order('points DESC')
    end
  end
  
  def skaters
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND position != "G" AND salary <= ? AND season = ?', params[:salary_max], @year).order('points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND position != "G" AND season = ?', @year).order('points DESC')
    end
  end
  
  def wingers
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND (position = "L" OR position ="R") AND salary <= ? AND season = ?', params[:salary_max], @year).order('points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND (position = "L" OR position ="R") AND season = ?', @year).order('points DESC')
    end
  end
  
  def centers
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND position = "C" AND salary <= ? AND season = ?', params[:salary_max], @year).order('points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND position = "C" AND season = ?', @year).order('points DESC')
    end
  end
  
  def defenders
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND position = "D" AND salary <= ? AND season = ?', params[:salary_max], @year).order('points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND position = "D" AND season = ?', @year).order('points DESC')
    end
  end

  def goalers
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND position = "G" AND salary <= ? AND season = ?', params[:salary_max], @year).order('points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND position = "G" AND season = ?', @year).order('points DESC')
    end
  end
  
  ############
  # RANK
  ############
  def skaters_rank
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND position != "G" AND salary <= ? AND season = ?', params[:salary_max], @year).order('my_rank_position ASC', 'points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND position != "G" AND season = ?', @year).order('my_rank_position ASC', 'points DESC')
    end
  end
  
  def skaters_global
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND position != "G" AND salary <= ? AND season = ?', params[:salary_max], @year).order('my_rank_global ASC', 'points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND position != "G" AND season = ?', @year).order('my_rank_global ASC', 'points DESC')
    end
  end

  def wingers_rank
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND (position = "L" OR position ="R") AND salary <= ? AND season = ?', params[:salary_max], @year).order('my_rank_position ASC', 'points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND (position = "L" OR position ="R") AND season = ?', @year).order('my_rank_position ASC', 'points DESC')
    end
  end
  
  def centers_rank
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND position = "C" AND salary <= ? AND season = ?', params[:salary_max], @year).order('my_rank_position ASC', 'points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND position = "C" AND season = ?', @year).order('my_rank_position ASC', 'points DESC')
    end
  end
  
  def defenders_rank
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND position = "D" AND salary <= ? AND season = ?', params[:salary_max], @year).order('my_rank_position ASC', 'points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND position = "D" AND season = ?', @year).order('my_rank_position ASC', 'points DESC')
    end
  end
  
  def goalers_rank
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND position = "G" AND salary <= ? AND season = ?', params[:salary_max], @year).order('my_rank_position ASC', 'points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND position = "G" AND season = ?', @year).order('my_rank_position ASC', 'points DESC')
    end
  end
  
  def rank
    @list = Player.where('rank != "nil"').order('rank ASC')
  end
  
  def team
    session[:return_to] = request.fullpath
  end
  
  def alainhello
    cookies[:whoami] = 'alain'
  end

  def alainbye
    cookies.delete(:whoami)
  end
  
  def team_roster
    session[:return_to] = request.fullpath
    @players = Player.where('drafted = "no" AND team = ? AND season = ?', params[:q], @year).order('points DESC')
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
      @poolers = ['Math', 'Ben', 'Mark', 'Alain', 'Couv']
      @max_to_draft = 20          
    end
    
    @total_players = Player.where('season = ?', @year).count
    @total_drafted = Player.where("drafted != 'no' AND season = ?", @year).count
    
    @nbr_drafted = {}
    @spent = {}
    @left = {}
    @average = {}
    
    @poolers.each do |person|
      @nbr_drafted[person]  = Player.where("drafted = '#{person}' AND season = ?", @year).count
      @spent[person]    = Player.select(:salary).where("drafted = '#{person}' AND season = ?", @year).sum(:salary)
      @left[person]     = @cap - @spent[person]
      if @nbr_drafted[person] == @max_to_draft
        @average[person] = @left[person]
      else
        @average[person]  = @left[person] / (@max_to_draft - @nbr_drafted[person])
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
