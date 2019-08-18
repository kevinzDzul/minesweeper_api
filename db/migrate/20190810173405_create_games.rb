class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name
      t.integer :row
      t.integer :column
      t.integer :mines
      t.integer :cell_open, default: 0
      t.string  :status, default:'started'
      t.text :board
      t.timestamps
    end
  end
end
