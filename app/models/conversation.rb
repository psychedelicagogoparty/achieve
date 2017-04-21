class Conversation < ActiveRecord::Base
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User' # 会話の送り手がユーザーモデルから参照できるようにアソシエーション
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User' #会話の受け手がユーザーモデルから参照できるようにアソシエーション
  has_many :messages, dependent: :destroy #会話(conversation)は複数のメッセージを持ち会話を削除するとメッセージも削除
  validates_uniqueness_of :sender_id, scope: :recipient_id #受け手と送り手の重複が発生しないようにする
  scope :between, -> (sender_id,recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND  conversations.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
  end

  def target_user(current_user)
    if sender_id == current_user.id
      User.find(recipient_id)
    elsif recipient_id == current_user.id
      User.find(sender_id)
    end
  end

end
