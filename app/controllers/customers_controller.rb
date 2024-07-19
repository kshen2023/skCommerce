class CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end

  def create
    province_name = customer_params[:province_name]
    @province = Province.find_by(province_name: province_name)

    if @province
      @customer = @province.customers.new(customer_params.except(:province_name))
      if @customer.save
        create_order(@customer) # 调用一个单独的方法来创建订单
        redirect_to customer_path(@customer), notice: 'Customer and order created successfully.'
      else
        render :new
      end
    else
      flash[:alert] = "Province not found"
      render :new
    end
  end

  def show
    @customer = Customer.find(params[:id])
    @orders = @customer.orders
  end

  private

  def create_order(customer)
    cart = Cart.find(session[:cart_id])
    order = customer.orders.create(total: cart.total_amount, status: 'pending')
    cart.items.each do |item|
      tax = Tax.find_by(province: customer.province)
      begin
        @order.order_items.create!(product: item.product, quantity: item.quantity, price: item.product.price, tax: tax)
      rescue => e
        Rails.logger.error "Failed to create order item: #{e.message}"
      end
    end
    session[:cart_id] = nil
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :province_name, :postal_code, :city, :address, :phone)
  end
end
