class AddTokenFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    add_column :users, :reset_token, :string
    add_column :users, :reset_token_sent_at, :datetime
  end
end
