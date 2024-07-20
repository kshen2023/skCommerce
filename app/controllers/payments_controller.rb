# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
  def create
    @order = Order.find(params[:order_id])
    @amount = ((@order.total + @order.gst + @order.pst + @order.hst) * 100).to_i  # Amount in cents

    customer = Stripe::Customer.create(
      email: current_customer.email,
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "Order ##{@order.id}",
      currency: 'usd'
    )

    @order.update(stripe_payment_id: charge.id, status: 'paid')
    redirect_to order_path(@order), notice: 'Payment was successful.'

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to order_path(@order)
  end
end
