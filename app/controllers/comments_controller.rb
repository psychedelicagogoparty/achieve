class CommentsController < ApplicationController

  #コメントを保存、投稿するためのメソッド
  def create
    #ログインしているユーザーに紐付けてインスタンスを生成する（buildメソッドを使用する）
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog

    #クライアントの要求に応じてフォーマットを変更する(respond_toメソッドを使用)
    respond_to do |format|
      if @comment.save
        format.html {redirect_to blog_path(@blog), notice: 'コメントを投稿しました'  }
        format.json {render :show, status: :created, location: @comment }
        # JS形式でスクリプトを返す=>JS形式のViewファイルが利用できる
        format.js {render :index}
      else
        format.html {render :new}
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  #コメントを削除するためのメソッド
  def destroy
    @comment = Comment.find(params[:id])

    #クライアントの要求に応じてフォーマットを変更する(respond_toメソッドを使用)
    respond_to do |format|
      if @comment.destroy
        format.html {redirect_to blog_path(@blog), notice: 'コメントを削除しました'  }
        format.json {render :show, status: :created, location: @comment }
        # JS形式でスクリプトを返す=>JS形式のViewファイルが利用できる
        format.js {render :index}
      else
        format.html {render :new}
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end


private
  #ストロングパラメーター
  def comment_params
    params.require(:comment).permit(:blog_id,:content)
  end
end
