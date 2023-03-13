class CreateSearchQueries < ActiveRecord::Migration[6.1]
  def change
    create_table :search_queries do |t|
      t.string :uid, null: false
      t.string :type, null: false
      t.text :query, null: false

      t.timestamps
    end
    add_index :search_queries, :uid, unique: true
  end
end
