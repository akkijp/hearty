class AddDiscardedAtToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :discarded_at, :datetime
  end
end
