class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one    :order

  has_one_attached :image

  belongs_to :item_category
  belongs_to :item_condition
  belongs_to :shipping_fee
  belongs_to :shipping_from
  belongs_to :shipping_time

  with_options presence: true do
    validates :item_name
    validates :item_description
    validates :item_category_id
    validates :item_condition_id
    validates :shipping_fee_id
    validates :shipping_from_id
    validates :shipping_time_id
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true }
    validates :image
  end

  with_options numericality: { other_than: 0 } do
    validates :item_category_id
    validates :item_condition_id
    validates :shipping_fee_id
    validates :shipping_from_id
    validates :shipping_time_id
  end
end
