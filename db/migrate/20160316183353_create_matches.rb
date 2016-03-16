class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :score
      t.datetime :date

      t.timestamps null: false
    end
  end
end
