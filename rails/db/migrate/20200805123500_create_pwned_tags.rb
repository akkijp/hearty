class CreatePwnedTags < ActiveRecord::Migration[7.0]
  def change
    create_table :pwned_tags do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    add_index :pwned_tags, :name
  end
end
