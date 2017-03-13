class BlogsController < ApplicationController
  #ログインしていなければblogを使用できないようにする(Deviseのauthenticate_user!メソッドを使用)
  before_action :authenticate_user!
  before_action :set_blog, only:[:edit, :update, :destroy] #共通のメソッドを事前呼び出し

  #すべてのブログを取得
  def index
    @blogs = Blog.all
  end

  #新規作成
  def new

    if params[:back] #戻るボタンが押された場合
      @blog = Blog.new(blogs_params)
    else
      #インスタンス変数(viewファイルに渡す変数)の宣言
      @blog = Blog.new
    end

  end

  def create
    @blog = Blog.new(blogs_params)
    #Blog.create(blogs_params) #ストロングパラメータを引数に渡す

    #user_idをカラムに代入する(current_userメソッドを使用する)
    @blog.user_id = current_user.id
    #@name. = Blog.find(current_user.id)

    #バリデーション成否の確認
    if @blog.save  #成功時
      redirect_to blogs_path,notice:"ブログを作成しました！"
      #作成と同時にメールを送信(使用するメソッドはdeliverメソッド)
      NoticeMailer.sendmail_blog(@blog).deliver
      #blogコントローラのindexアクションにリダイレクトする　noticeオプションでフィードバックメッセージを表示
    else#失敗時
      render 'new' #同じ画面の再描画
    end

  end
  #ここまで

  #既存ブログを編集
  #編集する内容の入力
  def edit

  end

  #編集した内容で更新する
  def update
    if @blog.update(blogs_params) #値を更新するためにupdateメソッドを使用(引数はblogの内容)
      redirect_to blogs_path,notice:"ブログを更新しました！"#indexアクションにリダイレクト
    else
      render 'new' #再描画
    end
  end
  #ここまで

  #既存ブログの消去
  def destroy
    @blog.destroy #値を削除するためにdestroyメソッドを使用(引数は不要)
    redirect_to blogs_path,notice:"ブログを削除しました！" #indexアクションにリダイレクト
  end
  #ここまで

  #入力内容確認用
  def confirm
    @blog = Blog.new(blogs_params)
    render :new if @blog.invalid? #確認時のバリデーション
  end
  #ここまで

  private
  #ストロングパラメータの設定
  def blogs_params
    params.require(:blog).permit(:title, :content) #paraｍsメソッドで取得した中でblogに関してtitleとcontentだけを許可する
  end

  def set_blog
      # edit, update, destroyで共通コード
      #引数が一つの場合はストロングパラメータを使用する必要はない
     @blog = Blog.find(params[:id]) #選択された該当のidの内容取得
  end

end
