class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_shipping = OrderShipping.new
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
  end

  def create
    @order_shipping = OrderShipping.new(order_params)
    if @order_shipping.valid?
      pay_item
      # shipping_from = ShippingFrom.find(@order_shipping.shipping_from_id)
      # @order_shipping.save(shipping_from) # 引数 shipping_from を渡す
      @order_shipping.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_shipping).permit(:zip_code, :shipping_from_id, :municipality, :house_number, :building_name,
     :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def find_item
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
  end
end
