class Post < ApplicationRecord

  has_attached_file :image, styles: { medium: "200x200>", thumb: "100x100>" },default_url: ':style/default.png'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  belongs_to :user
  has_many :comments
  has_many :likes, as: :like_on

end
