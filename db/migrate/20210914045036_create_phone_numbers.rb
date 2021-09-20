class CreatePhoneNumbers < ActiveRecord::Migration[6.1]
  def change
    create_table :phone_numbers do |t|
      t.string :phone_number
      t.string :pin
      t.boolean :verified

      t.timestamps
    end
  end
end
