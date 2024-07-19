class OrdersController < ApplicationController
  def new
    @cart = Cart.find(session[:cart_id])
    @order = Order.new
    @customer = Customer.find_by(id: params[:customer_id])
    if @cart.present? && @customer.present?
      @taxes = calculate_order_taxes(@cart.items)
    end
    @order_items = @order.order_items
  end

  def create
    @cart = Cart.find(session[:cart_id])
    @customer = Customer.find_or_initialize_by(email: customer_params[:email])

    @customer.assign_attributes(customer_params)
    @province = Province.find_by(province_name: customer_params[:province_name])
    @customer.province = @province if @province

    if @customer.save
      create_order(@customer)
      redirect_to order_path(@order), notice: 'Order created successfully.'
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    @customer = @order.customer
    @order_items = @order.order_items
    @taxes = calculate_order_taxes(@order_items)
  end

  private

  def create_order(customer)
    @order = customer.orders.build(total_amount: @cart.total_amount, status: 'pending')

    if @order.save
      @cart.items.each do |item|
        tax = Tax.find_by(province: customer.province)
        @order.order_items.create(product: item.product, quantity: item.quantity, price: item.product.price, tax: tax)
      end
      session[:cart_id] = nil # 清空购物车
    else
      render :new
    end
  end

  def calculate_order_taxes(order_items)
    gst_total = 0
    pst_total = 0
    hst_total = 0

    order_items.each do |item|
      gst_total += item.price * item.quantity * item.tax.gst
      pst_total += item.price * item.quantity * item.tax.pst
      hst_total += item.price * item.quantity * item.tax.hst
    end

    { gst: gst_total, pst: pst_total, hst: hst_total }
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :address, :city, :postal_code, :province_name, :phone)
  end

  def order_params
    params.require(:order).permit(:total_amount, :status)
  end
end
