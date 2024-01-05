

# テーブル設計

##users テーブル
|Column                     |Type             |Options                          |
|---------------------------|-----------------|---------------------------------|
|nickname                   |text             |null : false                     |
|email                      |text             |null : false , unique : true     |
|encrypted_password         |text             |null : false                     |
|last_name                  |text             |null : false                     |
|first_name                 |text             |null : false                     |
|last_name_kana             |text             |null : false                     |
|first_name_kana            |text             |null : false                     |
|dob_yyyy                   |string           |null : false                     |
|dob_m                      |string           |null : false                     |
|dob_d                      |string           |null : false                     |
### Association
- has_many : items  #items テーブルとのアソシエーション
- has_many : orders #orders テーブルとのアソシエーション

##items テーブル
|Column                     |Type             |Options                          |
|---------------------------|-----------------|---------------------------------|
|item_image                 |string           |null : false                     |
|item_name                  |text             |null : false                     |
|item_description           |text             |null : false                     |
|item_category              |text             |null : false                     |
|item_condition             |text             |null : false                     |
|shipping_fee               |string           |null : false                     |
|shipping_time              |string           |null : false                     |
|price                      |string           |null : false                     |
|seller_information         |references       |null : false , foreign_key: true |
|user_id                    |references       |null : false , foreign_key: true |
### Association
- belongs_to : user  #users テーブルとのアソシエーション
- has_one : order #orders テーブルとのアソシエーション

##orders テーブル (購入記録)
|Column                     |Type             |Options                          |
|---------------------------|-----------------|---------------------------------|
|purchased_item             |references       |null : false , foreign_key: true |
|item_id                    |references       |null : false , foreign_key: true |
|user_id                    |references       |null : false , foreign_key: true |
### Association
- belongs_to : user  #users テーブルとのアソシエーション
- has_one : item  #items テーブルとのアソシエーション

##shipping テーブル（発送先情報）
|Column                     |Type             |Options                          |
|---------------------------|-----------------|---------------------------------|
|zip_code                   |string           |null : false                     |
|prefecture                 |text             |null : false                     |
|municipality               |text             |null : false                     |
|house_number               |string           |null : false                     |
|building_name              |text             |                                 |
|phone_number               |string           |null : false                     |
|order_id                   |references       |null : false , foreign_key: true |
|user_id                    |references       |null : false , foreign_key: true |
### Association
- belongs_to : user   #users テーブルとのアソシエーション
- has_one : order  #orders テーブルとのアソシエーション
