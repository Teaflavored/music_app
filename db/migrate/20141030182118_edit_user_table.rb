class EditUserTable < ActiveRecord::Migration
  def change
    remove_column :users, :password_didgest
    add_column :users, :password_digest, :string
  end
end
