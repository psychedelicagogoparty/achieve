class MessagesController < ApplicationController

  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  # メッセージ内容の取得
  def index
    # 会話に紐づくメッセージを取得
    @messages = @conversation.messages

    # メッセージ数が10より多い場合は最新のメッセージ10に絞る
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    # そうでなければ10より大きいというフラグを無効にし会話にひもづくメッセージをすべて取得
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end
    # もしメッセージが最新（最後）のメッセージでかつユーザIDが自分（ログインユーザ）でなければ、その最新（最後）のメッセージを既読にする
    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true
      end
    end

    # 新規投稿のメッセージ用の変数を作成
    @message = @conversation.messages.build
  end

  # メッセージの新規登録
  def create
    @message = @conversation.messages.build(message_params)
    # メッセージの保存が完了したら会話に紐づく一覧画面へ遷移
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
  # ストロングパラメータの設定
  def message_params
    params.require(:message).permit(:body,:user_id)
  end
end
