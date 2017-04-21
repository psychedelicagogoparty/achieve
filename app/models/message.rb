class Message < ActiveRecord::Base
  # メッセージモデルはユーザモデルや会話モデルにひも付く
  # それぞれのひも付きがされた状態でしかメッセージを作成することはありえないので値が惣菜するかどうかの設定を記載
  belongs_to :conversation
  belongs_to :user

  #メッセージ内容・会話及びユーザーidが空でないことをチェック
  validates_presence_of :body, :conversation_id, :user_id
  def message_time
    #strftime:日付データをフォーマットするメソッド
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
