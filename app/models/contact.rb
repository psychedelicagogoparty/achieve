class Contact < ActiveRecord::Base
    validates :name, :email, :content, presence: true #バリデーションの設定
end
