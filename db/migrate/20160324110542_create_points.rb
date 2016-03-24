class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.belongs_to :match, index: true
      t.integer :order
      t.integer :local_points
      t.integer :visit_points

      t.timestamps null: false
    end
  end
end
