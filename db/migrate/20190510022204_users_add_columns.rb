class UsersAddColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :activated, :boolean, default: false, null: false
    add_column :users, :activation_token, :string, default: '1234', null: false
  end
end
