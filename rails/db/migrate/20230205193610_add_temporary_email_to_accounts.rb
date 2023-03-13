class AddTemporaryEmailToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :temporary_email, :string
    add_column :accounts, :temporary_email_token, :string
    add_column :accounts, :temporary_email_expires_at, :datetime
  end
end
