class OrderShipping
  include ActiveModel::Model
  attr_accessor :zip_code, :shipping_from_id, :municipality, :house_number, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :zip_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :shipping_from_id, numericality: {other_than: 0, message: "can't be blank"}
    validates :municipality
    validates :house_number
    validates :phone_number, format: {with: /\A[0-9]{11}\z/, message: "is invalid"}
    validates :user_id
    validates :item_id
    validates :token
  end

  def save(shipping_from)
    order = Order.create(user_id: user_id, item_id: item_id)
    Shipping.create(zip_code: zip_code, shipping_from_id: shipping_from.id, municipality: municipality,
                    house_number: house_number, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
