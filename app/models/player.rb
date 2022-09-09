class Player < ActiveRecord::Base
  
  #POOLERS = ['Math Ally', 'Ben', 'Mark', 'Alain', 'no', 'yes']   poolers + ['no', 'yes']
  POOLERS = ['Math', 'Alain', 'Mark', 'Ben', 'Couv', 'no', 'yes']
  #POOLERS = ['Math', 'Alain', 'Mark', 'Ben', 'no', 'yes']
  
  COLORS = ['green', 'yellow', 'orange', 'red', 'cyan', 'white']

  DEFAULT_RANK = 9999


  validates :name, :points, :goals, :assists, :games, :nhl_points, :nhl_goals, :nhl_assists, :nhl_rank, :position, :salary, :my_rank_global, :my_rank_position,
  presence: true

  validates :points, :goals, :assists, :games, :nhl_points, :nhl_goals, :nhl_assists, :nhl_rank, :salary,
  numericality: {greater_than_or_equal_to: 0}

  validates :my_rank_global, :my_rank_position,
  numericality: {greater_than_or_equal_to: 1}
  validate :my_rank_global_is_valid, :my_rank_position_is_valid

  #validates :nhl_rank,
  #uniqueness: true

  validates :position,
  format: { with: /D|C|L|R|G/i, message: 'must be D C L R G' }

  # validates :power_play, :pp_last_year,
  # allow_blank: true, format: { with: /F1|F2|F3|F4|F5|F6|D1|D2|D3|M|N/, message: 'must be F1 F2 F3 F4 F5 F6 D1 D2 D3 M N' }
    
  #validates :color, inclusion: COLORS
    
  validates :drafted,
  inclusion: POOLERS
    

  #validate :points_equal_sum_goals_assists, :nhl_points_equal_sum_nhl_goals_nhl_assists



  private

  def points_equal_sum_goals_assists
    errors.add(:points, "total of points different than sum of goals + assists") unless self.points != (self.goals + self.assists) 
  end


  def nhl_points_equal_sum_nhl_goals_nhl_assists
    errors.add(:nhl_points, "total of nhl_points different than sum of nhl_goals + nhl_assists") unless self.nhl_points != (self.nhl_goals + self.nhl_assists)
  end
  
  def pp_already
    if 1
      errors.add(:power_play, "pp rank already picked for this team")
    end
  end

  def my_rank_global_is_valid
    if my_rank_global != 9999
      unless (my_rank_global >= 1) && (my_rank_global <= 200)
        errors.add(:my_rank_global, "must be >= 1 and <= 200 or must be 9999")
      end
    end
  end

  def my_rank_position_is_valid
    if my_rank_position != 9999
      unless (my_rank_position >= 1) && (my_rank_position <= 200)
        errors.add(:my_rank_position, "must be >= 1 and <= 200 or must be 9999")
      end
    end
  end

end
