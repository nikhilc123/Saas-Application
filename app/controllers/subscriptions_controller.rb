class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  def new
    @plans = Plan.all
  end
  
  def create
    # Get the credit card details submitted by the form
    token = params[:stripeToken]
    plan = params[:plan][:stripe_id]
    email = current_user.email

    #Create a Customer
    customer = Stripe::Customer.create(
    :source => token,
    :plan => plan,
    :email => email )
    
    subscriptions = customer.subscriptions
    subscribed_plan = subscriptions.data.find {|o| o.plan.id == plan }
    #GEt current period, this is unix timestamp
    current_period_end = subscribed_plan.current_period_end
    #convert to datetime
    active_until = Time.at(current_period_end).to_datetime
    
    account = Account.find_by_email(current_user.email)
    account.stripe_plan_id = plan
    account.customer_id = customer.id
    account.active_until = 
    account.save!
    redirect_to root_path, :notice => "Succesfully subscribed to a plan!"
    rescue => e
      redirect_to new_subscription_path, :flash => { :error => e.message }
      
    
  end
end
