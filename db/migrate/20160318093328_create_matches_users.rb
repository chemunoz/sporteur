class CreateMatchesUsers < ActiveRecord::Migration
  def change
    create_table :matches_users, id: false do |t|
      t.belongs_to :match, index: true
      t.belongs_to :user, index: true
    end
  end
end
