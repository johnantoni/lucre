class ChargesController < ApplicationController
  def new
  end

  def error
  end

  def create
    charge = Stripe::Charge.create(
      :amount => (params[:amount].to_f * 100).abs.to_i,
      :currency => "usd",
      :card => params[:stripeToken],
      :description => params[:email]
    )
    @amount = params[:amount]
    @payment_id = charge.id

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to error_path
  end
end
