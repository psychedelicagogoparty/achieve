class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :uid, :string
  end
end
