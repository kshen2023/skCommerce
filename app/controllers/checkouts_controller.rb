class CheckoutsController < ApplicationController
  before_action :initialize_cart

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    @total = calculate_total(@cart, @customer.province_id)
    @order = Order.new(customer: @customer, total: @total, status: 'pending')

    if @customer.save && @order.save
      @cart.each do |item|
        product = Product.find(item['product_id'])
        @order.order_items.create!(product: product, quantity: item['quantity'], price: product.price)
      end

      reset_cart
      redirect_to order_path(@order), notice: 'Order completed successfully!'
    else
      render :new
    end
  end

  private

  def initialize_cart
    @cart = session[:cart] ||= []
  end

  def calculate_total(cart, province_id)
    subtotal = cart.sum do |item|
      product = Product.find(item['product_id'])
      product.price.to_f * item['quantity']
    end

    province = Province.find(province_id)
    gst = province.gst_rate * subtotal
    pst = province.pst_rate * subtotal
    hst = province.hst_rate * subtotal
    qst = province.qst_rate * subtotal

    subtotal + gst + pst + hst + qst
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :address, :city, :postal_code, :phone, :province_id)
  end

  def reset_cart
    session[:cart] = []
  end
end
