class AddRememberDigestToAdmins < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :remember_digest, :string
    add_column :admins, :remember_expires_at, :datetime, default: nil
  end
end
