class AddPersonalRankToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :my_rank_global, :integer, default: 0
    add_column :players, :my_rank_position, :integer, default: 0
  end
end
