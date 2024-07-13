# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  before_action :set_cart

  def show
    @items = @cart.items
  end

  def add_item
    product = Product.find(params[:product_id])
    item = @cart.items.find_or_initialize_by(product_id: product.id)
    item.quantity ||= 0
    item.quantity += 1
    item.save

    redirect_to cart_path, notice: 'Product added to cart.'
  end

  def remove_item
    item = @cart.items.find_by(product_id: params[:product_id])
    item.destroy if item

    redirect_to cart_path, notice: 'Product removed from cart.'
  end

  private

  def set_cart
    @cart = Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] = @cart.id
  end
end
