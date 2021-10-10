class ChangePersonalRankToPlayers < ActiveRecord::Migration
  def up
    change_column_default :players, :my_rank_global, 9999
    change_column_default :players, :my_rank_position, 9999
  end
  
  def down
    change_column_default :players, :my_rank_global, 0
    change_column_default :players, :my_rank_position, 0
  end
end
