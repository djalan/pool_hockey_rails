class ChangeDraftedTypeBoolToStringToPlayers < ActiveRecord::Migration
  def change
    change_column :players, :drafted, :string, default: 'no'
  end
end
