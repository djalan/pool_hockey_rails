class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.integer :points
      t.integer :goals
      t.integer :assists
      t.integer :rank
      t.integer :nhl_points
      t.integer :nhl_goals
      t.integer :nhl_assists
      t.integer :nhl_rank
      t.string :team
      t.string :last_team
      t.string :power_play
      t.string :pp_last_year
      t.string :position
      t.integer :salary

      t.timestamps
    end
  end
end
