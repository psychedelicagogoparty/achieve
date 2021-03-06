class User < ActiveRecord::Base
  #以下のメソッドhas_many :blogs により子モデル（blog）が複数紐づくアソシエーションを定義
  has_many :blogs,dependent: :destroy

  # CommentモデルのAssociationを設定
  has_many :comments, dependent: :destroy

  # 相互フォローの設定
  # usersテーブルのidカラムと参照関係を持つカラムを「follower_id」カラムであると定義
  has_many :relationships,foreign_key: "follower_id", dependent: :destroy
  #reverse_relationshipsというアソシエーションを定義します。
  has_many :reverse_relationships,foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy

  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable

  mount_uploader :avatar,AvatarUploader

  #指定のユーザをフォローする
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  #フォローしているかどうかを確認する
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  #指定のユーザのフォローを解除する
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  #facebook用
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
      user = User.find_by(email: auth.info.email)

       unless user
        user = User.new(
          name:     auth.extra.raw_info.name,
          provider: auth.provider,
          uid:      auth.uid,
          email:    auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
          image_url:   auth.info.image,
          password: Devise.friendly_token[0, 20]
        )
        user.skip_confirmation!
        user.save(validate: false)
      end
      user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    unless user
      user = User.new(
          name:     auth.info.nickname,
          image_url: auth.info.image,
          provider: auth.provider,
          uid:      auth.uid,
          email:    auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
          password: Devise.friendly_token[0, 20]
      )
      user.skip_confirmation!
      user.save
    end
    user
  end

# update_with_passwordのオーバーライド
#　providerが空:superでupdate_with_passwordに記述されている内容を上書き
#  providerが存在:current_passwordを削除してパスワードなしでも更新
  def update_with_password(params, *options)
    if provider.blank?
      super
    else
      params.delete :current_password
      update_without_password(params, *options)
    end
  end

  def self.create_unique_string
    SecureRandom.uuid #uidメソッドでランダムな文字列を作成
  end

end
