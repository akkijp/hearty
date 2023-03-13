class CreateStraipe < ActiveRecord::Migration[7.0]
  def change
    create_table :straipe do |t|
      t.string :customer_id, null: false

      t.timestamps
    end
  end
end
