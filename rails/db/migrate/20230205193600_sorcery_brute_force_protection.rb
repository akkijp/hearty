class SorceryBruteForceProtection < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :failed_logins_count, :integer, default: 0
    add_column :accounts, :lock_expires_at, :datetime, default: nil
    add_column :accounts, :unlock_token, :string, default: nil

    add_index :accounts, :unlock_token
  end
end
