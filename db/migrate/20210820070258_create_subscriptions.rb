class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :stripe_plna_id
      t.string :stripe_subscription_id
      t.boolean :is_trial
      t.datetime :trial_expire_at
      t.datetime :plan_expires_at
      t.string :status

      t.timestamps
    end
  end
end

