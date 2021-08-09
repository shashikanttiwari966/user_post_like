class Likes < ActiveRecord::Migration[6.1]
  def self.up
    create_table :likes do |t|
 
      t.timestamps
    end
  end

  def self.down
  end
end
