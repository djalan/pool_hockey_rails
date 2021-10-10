class AddSeasonToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :season, :string, default: 'unknown'
  end
end
