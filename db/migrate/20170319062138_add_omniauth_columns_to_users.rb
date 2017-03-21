class AddOmniauthColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string, null: false, default: ""
    add_column :users, :provider, :string, null: false, default: ""
    add_column :users, :image_url, :string

    #uidとproviderカラムに対してインデックス(索引)を設定しユニーク制約を設定
    #ユニーク制約：同じものを複数存在できないようにする
    add_index :users,[:uid,:provider], unique: true
  end
end
