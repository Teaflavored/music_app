class Addactivationtousers < ActiveRecord::Migration
  def change
    add_column :users, :activated, :boolean, default: false
    change_column :users, :activated, :boolean, null: false
    add_column :users, :activation_token, :string
    change_column :users, :activation_token, :string, null: false
  end
end
