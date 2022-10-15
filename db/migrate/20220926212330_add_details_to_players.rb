class AddDetailsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :info, :string
    add_column :players, :live_draft, :integer
  end
end
