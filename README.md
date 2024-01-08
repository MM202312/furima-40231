

# テーブル設計

##users テーブル
|Column                     |Type             |Options                          |
|---------------------------|-----------------|---------------------------------|
|nickname                   |string           |null : false                     |
|email                      |string           |null : false , unique : true     |
|encrypted_password         |string           |null : false                     |
|last_name                  |string           |null : false                     |
|first_name                 |string           |null : false                     |
|last_name_kana             |string           |null : false                     |
|first_name_kana            |string           |null : false                     |
|birth_date                 |date             |null : false                     |
### Association
- has_many : items  #items テーブルとのアソシエーション
- has_many : orders #orders テーブルとのアソシエーション

##items テーブル
|Column                     |Type             |Options                          |
|---------------------------|-----------------|---------------------------------|
|item_name                  |string           |null : false                     |
|item_description           |text             |null : false                     |
|item_category_id           |integer          |null : false                     |
|item_condition_id          |integer          |null : false                     |
|shipping_fee_id            |integer          |null : false                     |
|shipping_from_id           |integer          |null : false                     |
|shipping_time_id           |integer          |null : false                     |
|price                      |integer          |null : false                     |
|user                       |references       |null : false , foreign_key: true |
### Association
- belongs_to : user  #users テーブルとのアソシエーション
- has_one : order #orders テーブルとのアソシエーション

##orders テーブル (購入記録)
|Column                     |Type             |Options                          |
|---------------------------|-----------------|---------------------------------|
|user                       |references       |null : false , foreign_key: true |
|item                       |references       |null : false , foreign_key: true |
### Association
- belongs_to : user  #users テーブルとのアソシエーション
- belongs_to : item  #items テーブルとのアソシエーション
- has_one : shipping  #shippings テーブルとのアソシエーション

##shippings テーブル（発送先情報）
|Column                     |Type             |Options                          |
|---------------------------|-----------------|---------------------------------|
|zip_code                   |string           |null : false                     |
|shipping_from_id           |integer          |null : false                     |
|municipality               |string           |null : false                     |
|house_number               |string           |null : false                     |
|building_name              |string           |                                 |
|phone_number               |string           |null : false                     |
|order                      |references       |null : false , foreign_key: true |
### Association
- belongs_to : order  #orders テーブルとのアソシエーション