FactoryBot.define do
  factory :item do
    item_name { Faker::Name.name }
    item_description { Faker::Lorem.sentence }
    item_category_id { rand(1..10) }
    item_condition_id { rand(1..6) }
    shipping_fee_id { rand(1..2) }
    shipping_from_id { rand(1..47) }
    shipping_time_id { rand(1..10) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
