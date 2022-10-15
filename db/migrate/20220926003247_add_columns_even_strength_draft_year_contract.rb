class AddColumnsEvenStrengthDraftYearContract < ActiveRecord::Migration
  def change
    add_column :players, :even_strength, :string
    add_column :players, :draft_year, :string
    add_column :players, :contract, :string
  end
end
