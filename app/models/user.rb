class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :matches, foreign_key: "creator_id"
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :matches
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", minithumb: "50x50>" }, default_url: "/images/avatar/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  has_many :comments

  validates :name, length: {maximum: 30}
  validates :name, format: {with: /\A[a-zA-ZÑñ0-9]+\Z/} #Ver rubular.com
  validates :name, uniqueness: true
end
