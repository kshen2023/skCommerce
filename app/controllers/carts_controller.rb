class CartsController < ApplicationController
  before_action :initialize_cart

  def show
    @cart_items = @cart.map do |item|
      product = Product.find(item['product_id'])
      {
        product: product,
        quantity: item['quantity'],
        total_price: product.price.to_f * item['quantity']
      }
    end
  end

  def add_item
    product_id = params[:product_id].to_i
    quantity = params[:quantity].to_i

    item = @cart.find { |i| i['product_id'] == product_id }

    if item
      item['quantity'] += quantity
    else
      @cart << { 'product_id' => product_id, 'quantity' => quantity }
    end

    save_cart
    redirect_to cart_path, notice: 'Product added to cart.'
  end

  def remove_item
    product_id = params[:product_id].to_i

    @cart.reject! { |item| item['product_id'] == product_id }

    save_cart
    redirect_to cart_path, notice: 'Product removed from cart.'
  end

  private

  def initialize_cart
    @cart = session[:cart] ||= []
  end

  def save_cart
    session[:cart] = @cart
  end
end
