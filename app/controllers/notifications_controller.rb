class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    # 自分の未読の通知のみ取得し新しい順に並び替える
    @notifications = Notification.where(user_id: current_user.id).where(read: false).order(created_at: :desc)
  end
end
