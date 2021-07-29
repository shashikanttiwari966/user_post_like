class Like < ApplicationRecord
  belongs_to :user
  belongs_to :like_on, polymorphic: true
end
