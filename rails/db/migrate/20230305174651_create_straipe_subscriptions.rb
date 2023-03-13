class CreateStraipeSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :straipe_subscriptions do |t|
      t.string :subscription_id, null: false

      t.timestamps
    end
  end
end
