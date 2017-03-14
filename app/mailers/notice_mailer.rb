class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_blog.subject
  #

  #ブログ送信の通知をメールで送信する
  #引数としてblogを追加する
  def sendmail_blog(blog)
    #@greeting = "Hi"
    @blog = blog

    #メール送信時に自分のアドレスに送信
    mail to: "september_girl_friend@yahoo.co.jp",
     subject: '【Achieve】ブログが投稿されました'
  end

  #お問い合わせ完了の通知をメールで送信する
  #引数としてblogを追加する
  def sendmail_contact(contact)
    #@greeting = "Hi"
    @contact = contact

    #メール送信時に自分のアドレスに送信
    mail to: "#{@contact.email}",
     subject: '【Achieve】お問い合わせが完了しました'
  end
end
