class AddExpirydateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_token_expiry, :datetime
  end
end
