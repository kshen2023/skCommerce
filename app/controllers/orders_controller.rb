class OrdersController < ApplicationController


  def new
    @cart = Cart.find(session[:cart_id])
    @order = Order.new
    @customer = Customer.new(province: 'Manitoba')  # 初始化一个默认值
    @taxes = calculate_taxes(@customer.province, @cart.total_amount) if @customer.province.present?
  end

  def create
    @cart = Cart.find(session[:cart_id])
    @customer = Customer.find_or_initialize_by(email: customer_params[:email])

    # If the customer is new, set their attributes and save
    if @customer.new_record?
      @customer.assign_attributes(customer_params)
      if @customer.save
        create_order(@customer)
      else
        render :new # or handle the case when customer saving fails
      end
    else
      create_order(@customer)
    end
  end

  private

  def create_order(customer)
    @order = customer.orders.build

    # Calculate total_amount, gst, pst, hst dynamically based on cart items
    taxes = calculate_taxes(customer.province, @cart.total_amount)
    @order.total_amount = @cart.total_amount
    @order.gst = taxes[:gst]
    @order.pst = taxes[:pst]
    @order.hst = taxes[:hst]

    if @order.save
      @cart.items.each do |item|
        # Find the tax_id associated with the item's product's province
        tax = Tax.find_by(province: customer.province)
        @order.order_items.create(product: item.product, quantity: item.quantity, price: item.product.price, tax_id: tax.id)
      end
      session[:cart_id] = nil
      redirect_to order_path(@order), notice: 'Order placed successfully'
    else
      render :new
    end
  end

  def calculate_taxes(province, total_amount)
    tax = Tax.find_by(province: province)

    if tax.present?
      gst_amount = total_amount * tax.gst
      pst_amount = total_amount * tax.pst
      hst_amount = total_amount * tax.hst
      { gst: gst_amount, pst: pst_amount, hst: hst_amount }
    else
      # Handle the case where tax record for the province is not found
      { gst: 0, pst: 0, hst: 0 }
    end
  end
  def show
    @order = Order.find(params[:id])
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :address, :province, :phone)
  end

  def order_params
    params.require(:order).permit(:total_amount, :gst, :pst, :hst) # Add other order attributes if needed
  end
end
