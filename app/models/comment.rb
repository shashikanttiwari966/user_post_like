class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :post
	has_many :likes, as: :like_on
end
