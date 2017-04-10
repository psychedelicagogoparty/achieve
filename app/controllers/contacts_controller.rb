class ContactsController < ApplicationController

    def new
        if params[:back] #確認フォームで戻るボタンが押された場合
            @contact = Contact.new(contacts_params) #引数にラベルに入力された内容を入れる
        else
            @contact = Contact.new #インスタンス変数の定義(contactモデルのインスタンスを生成)
        end
    end

    def create
        @contact = Contact.create(contacts_params) #ストロングパラメータを引数に渡す
        if @contact.save #バリデーション(空入力)による分岐
            # redirect_to new_contact_path,notice:"お問い合わせありがとうございました！" #contactコントローラのnewアクションにリダイレクトする
             redirect_to root_path,notice:"お問い合わせが完了しました！" #contactコントローラのnewアクションにリダイレクトする
             NoticeMailer.sendmail_contact(@contact).deliver
        else
            render "new" #お問い合わせ画面の再描画
        end
    end

    #入力内容確認用
    def confirm
        @contact =Contact.new(contacts_params)
        render :new if @contact.invalid? #確認時にバリデーション実行

      　  # if @contact.invalid ?
          #ifを中心に右辺の内容が正ならば左辺を実行
          # render　:new if @contact.invalid? #確認時にバリデーション実行

          # if @contact.invalid ?
          #   render :new if @contact.invalid? #確認時にバリデーション実行
          # end mm


    end

    private
    #ストロングパラメータの設定
    #rails内でparamsメソッドを使用する場合,ストロングパラメータを使用する必要がある
    def contacts_params
      params.require(:contact).permit(:name, :email, :content) #paraｍsメソッドで取得した中でcontentに関してname,email,contentだけを許可する
    end

end
