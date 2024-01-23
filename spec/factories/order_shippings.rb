FactoryBot.define do
  factory :order_shipping do
   zip_code { '123-4567' }
   shipping_from_id { rand(1..47) }
   municipality { '渋谷区' }
   house_number { '代々木1-1-1' }
   phone_number { '09012345678' }
   token {"tok_abcdefghijk00000000000000000"}
  end
end
