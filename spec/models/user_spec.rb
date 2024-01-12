require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    context '新規登録成功' do
      it 'すべての項目の入力について問題なし' do
        user = User.new(
          nickname: 'test',
          email: 'test@example.com',
          password: 'abc000',
          password_confirmation: 'abc000',
          last_name: 'てすと',
          first_name: '太郎',
          last_name_kana: 'テスト',
          first_name_kana: 'タロウ',
          birth_date: Date.new(2000, 1, 1)
)
        expect(user).to be_valid
      end
    end

    context '新規登録失敗' do
      it 'nicknameが空では登録できない' do
        user = build(:user, nickname: '')
        user.valid?
        expect(user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        user = build(:user, email: '')
        user.valid?
        expect(user.errors.full_messages).to include("Email can't be blank")
      end

      it 'emailに@が含まれていないと登録できない' do
        user = build(:user, email: 'testexample')
        user.valid?
        expect(user.errors.full_messages).to include('Email is invalid')
      end

      it 'emailが一意性であること' do
        existing_user = create(:user, email: 'test@example.com')
        user = build(:user, email: 'test@example.com')
        user.valid?
        expect(user.errors.full_messages).to include('Email has already been taken')
      end

      it 'passwordが空では登録できない' do
        user = build(:user, password: '')
        user.valid?
        expect(user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが6文字未満では登録できない' do
        user = build(:user, password: 'abc00', password_confirmation: 'abc00')
        user.valid?
        expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordは半角英数字混合であること' do
        user = build(:user, password: 'password')
        user.valid?
        expect(user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end

      it 'password_confirmationが空では登録できない' do
        user = build(:user, password_confirmation: '')
        user.valid?
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordとpassword_confirmationは一致していること' do
        user = build(:user, password: 'password', password_confirmation: 'different_password')
        user.valid?
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'last_nameが空では登録できない' do
        user = build(:user, last_name: '')
        user.valid?
        expect(user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_nameは全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        user = build(:user, last_name: 'Test') # 不正な入力例（半角文字）
        user.valid?
        expect(user.errors.full_messages).to include('Last name is invalid')
      end

      it 'first_nameが空では登録できない' do
        user = build(:user, first_name: '')
        user.valid?
        expect(user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_nameは全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        user = build(:user, first_name: 'Test') # 不正な入力例（半角文字）
        user.valid?
        expect(user.errors.full_messages).to include('First name is invalid')
      end

      it 'last_name_kanaが空では登録できない' do
        user = build(:user, last_name_kana: '')
        user.valid?
        expect(user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'last_name_kanaは全角（カタカナ）での入力が必須であること' do
        user = build(:user, last_name_kana: 'Test')  # 不正な入力例（半角文字）
        user.valid?
        expect(user.errors.full_messages).to include('Last name kana is invalid')

        user = build(:user, last_name_kana: 'てすと')  # 不正な入力例（ひらがな）
        user.valid?
        expect(user.errors.full_messages).to include('Last name kana is invalid')

        user = build(:user, last_name_kana: '試験')  # 不正な入力例（漢字）
        user.valid?
        expect(user.errors.full_messages).to include('Last name kana is invalid')
      end

      it 'first_name_kanaが空では登録できない' do
        user = build(:user, first_name_kana: '')
        user.valid?
        expect(user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'first_name_kanaは全角（カタカナ）での入力が必須であること' do
        user = build(:user, first_name_kana: 'Test')  # 不正な入力例（半角文字）
        user.valid?
        expect(user.errors.full_messages).to include('First name kana is invalid')

        user = build(:user, first_name_kana: 'てすと')  # 不正な入力例（ひらがな）
        user.valid?
        expect(user.errors.full_messages).to include('First name kana is invalid')

        user = build(:user, first_name_kana: '試験')  # 不正な入力例（漢字）
        user.valid?
        expect(user.errors.full_messages).to include('First name kana is invalid')
      end

      it 'birth_dateが空では登録できない' do
        user = build(:user, birth_date: nil)
        user.valid?
        expect(user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
