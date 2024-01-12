class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
 
  # 半角英数字混合／6文字以上＆確認用と一致条件はデフォルト
   PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'
 
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/ } # 全角漢字かなカナ
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/ } # 全角漢字かなカナ
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ } # 全角カナ
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ } # 全角カナ
  validates :birth_date, presence: true
end
