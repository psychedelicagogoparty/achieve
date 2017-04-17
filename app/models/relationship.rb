class Relationship < ActiveRecord::Base

  # follower,followedカラムはユーザーモデルと参照関係をもつ
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

end
