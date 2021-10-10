class AddGamesToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :games, :integer
  end
end
