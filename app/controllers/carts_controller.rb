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

  def update_item
    item = @cart.items.find(params[:id])
    if item.update(item_params)
      redirect_to cart_path, notice: 'Product quantity updated.'
    else
      redirect_to cart_path, alert: 'Failed to update product quantity.'
    end
  end

  private

  def set_cart
    @cart = Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] = @cart.id
  end

  def item_params
    params.require(:item).permit(:quantity)
  end
end
