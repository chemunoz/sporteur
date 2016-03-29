class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :match, index: true
      t.belongs_to :user, index: true
      t.text :message

      t.timestamps null: false
    end
  end
end
