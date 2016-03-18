class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :matches, foreign_key: "creator_id"
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :matches
end
