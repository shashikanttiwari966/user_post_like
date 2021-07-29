class AddLikeOnToLike < ActiveRecord::Migration[6.1]
  def change
    add_reference :likes, :like_on, polymorphic: true, null: false
  end
end
