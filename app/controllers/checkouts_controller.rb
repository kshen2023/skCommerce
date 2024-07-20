class CheckoutsController < ApplicationController
  before_action :authenticate_customer!
  before_action :initialize_cart

  def new
    @customer = current_customer
  end

  def create
    @customer = current_customer

    if @customer.nil?
      flash[:alert] = "You need to be logged in to complete the checkout."
      redirect_to new_customer_session_path and return
    end

    @total = calculate_total(@cart, @customer.province_id)
    @order = Order.new(customer: @customer, total: @total, status: 'pending')

    if @order.save
      @cart.each do |item|
        product = Product.find(item['product_id'])
        @order.order_items.create!(product_id: product.id, quantity: item['quantity'], price: product.price)
      end

      reset_cart
      redirect_to order_path(@order), notice: 'Order completed successfully!'
    else
      flash[:alert] = @order.errors.full_messages.join(", ")
      Rails.logger.error("Order creation failed: #{@order.errors.full_messages.join(", ")}")
      render :new
    end
  rescue => e
    flash[:alert] = "An error occurred: #{e.message}"
    Rails.logger.error("An error occurred during order creation: #{e.message}")
    Rails.logger.error(e.backtrace.join("\n"))
    render :new
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
    gst = (province.gst_rate || 0) * subtotal
    pst = (province.pst_rate || 0) * subtotal
    hst = (province.hst_rate || 0) * subtotal
    # qst = (province.qst_rate || 0) * subtotal

    subtotal + gst + pst + hst
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :address, :city, :postal_code, :phone, :province_id)
  end

  def reset_cart
    session[:cart] = []
  end
end
