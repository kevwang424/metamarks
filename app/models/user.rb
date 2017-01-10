class User < ApplicationRecord
  has_many :bookmarks
  has_many :bookmark_tags, through: :bookmarks
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

end
