class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  #以下のメソッドhas_many :hoges により子モデル（hoge）が複数紐づくアソシエーションを定義
  has_many :blogs
end
