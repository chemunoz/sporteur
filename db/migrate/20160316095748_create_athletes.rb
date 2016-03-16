class CreateAthletes < ActiveRecord::Migration
  def change
    create_table :athletes do |t|
      t.references :user, index: true
      t.references :role, index: true
      t.references :sport, index: true

      t.timestamps null: false
    end
  end
end
