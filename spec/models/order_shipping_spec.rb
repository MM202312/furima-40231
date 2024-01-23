require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_shipping = FactoryBot.build(:order_shipping, user_id: @user.id, item_id: @item.id)
  end

  describe '購入内容の確認' do
    context '購入成功' do
      it 'すべての項目の入力について問題なし' do
        expect(@order_shipping).to be_valid
      end
    end

    context '購入失敗' do
      it '郵便番号が空では登録できない' do
        @order_shipping.zip_code = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Zip code can't be blank")
      end
      it '郵便番号はハイフンを含まないと登録できない' do
        @order_shipping.zip_code = '1234567' # ハイフンがない場合
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Zip code is invalid. Include hyphen(-)")
      end
      it '郵便番号は「3桁ハイフン4桁」の半角文字列でないと登録できない' do
        @order_shipping.zip_code = '123-456' # 長さが足りない場合
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Zip code is invalid. Include hyphen(-)")
      end

      it '都道府県が空では登録できない' do
        @order_shipping.shipping_from_id = 0
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Shipping from can't be blank")
      end

      it '市区町村が空では登録できない' do
        @order_shipping.municipality = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Municipality can't be blank")
      end

      it '番地が空では登録できない' do
        @order_shipping.house_number = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("House number can't be blank")
      end

      it '電話番号が空では登録できない' do
        @order_shipping.phone_number = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号は10 or 11桁でないと登録できない' do
        @order_shipping.phone_number = '123456789012' # 12桁の場合
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number is invalid")
      end
      it '電話番号は半角数字でないと登録できない' do
        @order_shipping.phone_number = '123-456-7890' # 数字以外が含まれる場合
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number is invalid")
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @order_shipping.user_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("User can't be blank")
      end

      it '商品が紐付いていなければ投稿できない' do
        @order_shipping.item_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Item can't be blank")
      end

      it 'tokenが空では登録できないこと' do
        @order_shipping.token = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
