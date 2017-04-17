class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps null: false
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    # Uniqueインデックスを設定 => follower_idとfollowed_idを同じ組み合わせで保存しない
    add_index :relationships, [:follower_id,:followed_id],unique:true
  end
end
