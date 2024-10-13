class AddDetailsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :draft_position, :integer
    add_column :players, :age, :string
    add_column :players, :dff, :float
    add_column :players, :reldff, :float
    add_column :players, :g60, :float
    add_column :players, :p60, :float
  end
end
