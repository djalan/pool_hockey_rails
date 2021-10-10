class AddDraftedToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :drafted, :boolean
  end
end
