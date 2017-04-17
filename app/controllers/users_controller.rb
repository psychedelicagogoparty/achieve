class UsersController < ApplicationController
  def index
    @users = User.all

  end

  def show
    # 特定のユーザーidのユーザーを取得
    @user = User.find(params[:id])
    # binding.pry
    #フォローしたユーザーの値を取得
    @followers = @user.followed_users
    #フォローされたユーザーの値を取得
    @followed_users = @user.followers
  end
end
