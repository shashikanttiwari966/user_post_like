class AddPhoneNoToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :phone_no, :string
  end
end
