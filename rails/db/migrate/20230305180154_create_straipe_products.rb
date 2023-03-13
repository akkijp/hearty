class CreateStraipeProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :straipe_products do |t|
      t.string :product_id, null: false

      t.timestamps
    end
  end
end
