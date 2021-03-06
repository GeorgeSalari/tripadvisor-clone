class ChangeUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :oauth_expires_at, :datetime
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :oauth_token, :string
  end
end
