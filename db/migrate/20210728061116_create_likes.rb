class CreateLikes < ActiveRecord::Migration[6.1]
  def self.up
    create_table :old_likes do |t|
      t.integer :like_on_id
      t.string :like_on_type

      t.timestamps
    end
  end

  def self.down
  end
end
