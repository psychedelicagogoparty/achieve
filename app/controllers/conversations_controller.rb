# 会話用のコントローラー
class ConversationsController < ApplicationController
before_action :authenticate_user!

  def index
    @users = User.all
    @conversations = Conversation.all
  end

  # 会話作成のメソッド
  def create

    # Conversationテーブルのsender_idとrecipient_id間の値が存在しているかどうか(過去に会話があるかどうか)
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      # ある場合は値(会話)を取得する
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      # ない場合は強制的にメッセージを生成する
      @conversation = Conversation.create!(conversation_params)
    end

    # 上記どちらの状態でもメッセージ一覧画面へ遷移
    redirect_to conversation_messages_path(@conversation)
  end

  private
    # ストロングパラメーターの設定
    def conversation_params
      params.permit(:sender_id,:recipient_id)
    end

end
