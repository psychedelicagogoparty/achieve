require 'rails_helper'

# テストを書く際は、まず最初にこのようにあるべき姿を書き出す
# 例
# ・ブログの本文がなければ、無効である
# ・お問い合わせの名前がなければ無効である


# describe以下に期待する内容を記載
describe Contact do

  # 名前、内容、メールアドレスがあれば有効な状態であること_テスト①
  it "is valid with name_content_mail" do
    contact = Contact.new(name:"テストや！", content: '暑いです', email: "oreo@test.com")
    # contact = Contact.new(email: "oreo@test.com")
    # expectメソッドにcontactを渡してcontactが有効かどうか判断 結果：true or false
    expect(contact).to be_valid #be_validマッチャを使用

  end

  #名前、内容、メールアドレスがなければ無効であること_テスト②
  it "is invalid without a name_content_mail" do
    contact = Contact.new
      # expectメソッドにcontactを渡してcontactが有効でないかどうか判断 結果：true or false
    expect(contact).not_to be_valid
  end

  #名前、内容、メールアドレスがなければ無効であること
  it "is valid with name_content_mail" do
    contact = Contact.new
    contact.valid?
    expect(contact.errors[:name]).to include("を入力してください")
    expect(contact.errors[:content]).to include("を入力してください")
    expect(contact.errors[:email]).to include("を入力してください")
  end

end
