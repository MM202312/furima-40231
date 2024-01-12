FactoryBot.define do
  factory :user do
    nickname { 'test' }
    email { Faker::Internet.email }
    password { 'abc000' }
    password_confirmation { 'abc000' }
    last_name { 'てすと' }
    first_name { '太郎' }
    last_name_kana { 'テスト' }
    first_name_kana { 'タロウ' }
    birth_date { Date.new(2000, 1, 1) }
  end
end
