require 'rails_helper'

# テストを書く際は、まず最初にこのようにあるべき姿を書き出す
# 例
# ・ブログの本文がなければ、無効である
# ・お問い合わせの名前がなければ無効である


# describe以下に期待する内容を記載
describe Blog do
  # タイトルがあれば有効な状態であること_テスト①
  it "is valid with title" do
    blog = Blog.new(title:"neko", content: '暑いです')
    # expectメソッドにblogを渡してblogが有効かどうか判断 結果：true or false
    expect(blog).to be_valid #be_validマッチャを使用

  end

  #タイトルがなければ無効であること_テスト②
  it "is invalid without a title" do
    blog = Blog.new
      # expectメソッドにblogを渡してblogが有効でないかどうか判断 結果：true or false
    expect(blog).not_to be_valid
  end

  #タイトルがなければ無効であること
  it "is valid with title" do
    blog = Blog.new
    blog.valid?
    expect(blog.errors[:title]).to include("を入力してください")
  end

end
