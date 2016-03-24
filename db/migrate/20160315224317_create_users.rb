class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :height
      t.integer :weight
      t.string :hand_orientation
      t.float :ntrp, default: 1

      t.timestamps null: false
    end
  end
end
