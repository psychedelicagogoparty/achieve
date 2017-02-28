class Blog < ActiveRecord::Base
    validates :title,presence: true #titleにバリデーションを設定・空入力を禁止
end
