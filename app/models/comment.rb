class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog

  #notificationsへのアソシエーション(コメント削除時に通知も削除)
  has_many :notifications,dependent: :destroy
end
