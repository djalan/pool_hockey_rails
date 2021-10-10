class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
    
  # GET /players
  # GET /players.json
  def index
    @players = Player.where('season = ?', @year).order('points DESC')
    #@players = Player.where('position = "G" and salary = 0').order('points DESC')
    #@players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render action: 'show', status: :created, location: @player }
      else
        format.html { render action: 'new' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end


  #############################
  # DRAFT
  #############################
  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
    def update
      case @mode
      when 'draft'
        respond_to do |format|
          if @player.update(player_params)
            format.html { redirect_to @player, notice: 'Player was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: 'edit' }
            format.json { render json: @player.errors, status: :unprocessable_entity }
          end
        end

      
      when 'prep'
    
        puts "Now changing positions (not global) if required"
        if player_params[:my_rank_position].to_i != @player.my_rank_position.to_i
          puts 'rank_actual', @rank_actual = @player.my_rank_position.to_i
          puts 'rank_new', @rank_new = player_params[:my_rank_position].to_i
          puts 'from_what_rank', @from_what_rank = [@rank_actual, @rank_new].min
      
          @players_to_shift = if @player.position == 'L' or @player.position == 'R'
            Player.where("season = ? AND my_rank_position != 9999 AND my_rank_position >= ? AND (position = 'R' OR position = 'L')", \
              @year, @from_what_rank).order('my_rank_position ASC')
          else
            Player.where("season = ? AND my_rank_position != 9999 AND my_rank_position >= ? AND position = ?", \
              @year, @from_what_rank, @player.position).order('my_rank_position ASC  ')
          end
      
          puts 'p count', @players_to_shift.count
          puts 'rank_max', @rank_max = @players_to_shift.maximum(:my_rank_position).to_i
    
          if @rank_new > @rank_actual
            puts 'Start: decrease'
            @i = @rank_actual + 1
            while @i <= @rank_new and @i <= @rank_max
              puts @i
              p = @players_to_shift.where('my_rank_position = ?', @i).take!
              p.my_rank_position = p.my_rank_position - 1
              if p.save
                puts 'A position was decreased with success'
              else
                puts 'A position was NOT decreased with success'
              end
              @i = @i + 1
            end
          elsif @rank_new < @rank_actual and @rank_actual != 9999
            puts 'Start: increase when already ranked'
            @i = @rank_actual - 1
            while @i >= @rank_new
              puts @i
              p = @players_to_shift.where('my_rank_position = ?', @i).take!
              p.my_rank_position = p.my_rank_position + 1
              if p.save
                puts 'A position was increased successfully! (saved in DB)'
              else
                puts 'A position was --NOT-- increased successfully! (not saved in DB)'
              end
              @i = @i - 1
            end
          elsif @rank_new < @rank_actual and @rank_actual == 9999
            puts 'Start: increase when actual 9999'
            @i = @rank_max
            while @i >= @rank_new
              puts @i
              p = @players_to_shift.where('my_rank_position = ?', @i).take!
              p.my_rank_position = p.my_rank_position + 1
              if p.save
                puts 'A position was increased successfully! (saved in DB) when 9999'
              else
                puts 'A position was --NOT-- increased successfully! (not saved in DB) when 9999'
              end
              @i = @i - 1
            end
          end
        end
  

        puts "Now changing positions (global) if required"
        if player_params[:my_rank_global].to_i != @player.my_rank_global.to_i
          puts 'rank_actual', @rank_actual = @player.my_rank_global.to_i
          puts 'rank_new', @rank_new = player_params[:my_rank_global].to_i
          puts 'from_what_rank', @from_what_rank = [@rank_actual, @rank_new].min
      
          @players_to_shift = Player.where("season = ? AND my_rank_global != 9999 AND my_rank_global >= ? AND (position = 'R' OR position = 'L' OR position = 'C' OR position = 'D')", @year, @from_what_rank).order('my_rank_global ASC', 'points DESC')
      
          puts 'p count', @players_to_shift.count
          puts 'rank_max', @rank_max = @players_to_shift.maximum(:my_rank_global).to_i
    
          if @rank_new > @rank_actual
            puts 'Start: decrease'
            @i = @rank_actual + 1
            while @i <= @rank_new and @i <= @rank_max
              puts @i
              p = @players_to_shift.where('my_rank_global = ?', @i).take!
              p.my_rank_global = p.my_rank_global - 1
              if p.save
                puts 'A position was decreased with success'
              else
                puts 'A position was NOT decreased with success'
              end
              @i = @i + 1
            end
          elsif @rank_new < @rank_actual and @rank_actual != 9999
            puts 'Start: increase when already ranked'
            @i = @rank_actual - 1
            while @i >= @rank_new
              puts @i
              p = @players_to_shift.where('my_rank_global = ?', @i).take!
              p.my_rank_global = p.my_rank_global + 1
              if p.save
                puts 'A position was increased successfully! (saved in DB)'
              else
                puts 'A position was --NOT-- increased successfully! (not saved in DB)'
              end
              @i = @i - 1
            end
          elsif @rank_new < @rank_actual and @rank_actual == 9999
            puts 'Start: increase when actual 9999'
            @i = @rank_max
            while @i >= @rank_new
              puts @i
              p = @players_to_shift.where('my_rank_global = ?', @i).take!
              p.my_rank_global = p.my_rank_global + 1
              if p.save
                puts 'A position was increased successfully! (saved in DB) when 9999'
              else
                puts 'A position was --NOT-- increased successfully! (not saved in DB) when 9999'
              end
              @i = @i - 1
            end
          end
        end  
    
    
        puts "Now updating player and redirecting surfer"
        respond_to do |format|
          if @player.update(player_params)
            #format.html { redirect_to @player, notice: 'Player was successfully updated.' }
            format.html { redirect_to session[:return_to], notice: 'Player was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: 'edit' }
            format.json { render json: @player.errors, status: :unprocessable_entity }
          end
        end #respond_to
      end #update
    
    end #case @mode
    
    
    

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end
  
  
  def edit_individual
    @players = Player.find(params[:player_ids])
  end
  
  
  def update_individual
    @players = Player.update(params[:players].keys, params[:players].values).reject { |p| p.errors.empty? }
    if @players.empty?
      puts 'updated'
      flash[:notice] = "Players updated"
      redirect_to players_path
    else
      puts 'not working'
      flash[:notice] = "Players --NOT-- updated"
      render :action => "edit_individual"
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:name, :points, :goals, :assists, :rank, :nhl_points, :nhl_goals, :nhl_assists, :nhl_rank, :team, :last_team, :power_play, :pp_last_year, :position, :salary, :color, :games, :drafted, :season, :my_rank_global, :my_rank_position)
    end
    
end
