class ChangeUsernameToEmailInUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    remove_column :users, :username
  end
end
