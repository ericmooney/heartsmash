class SubscriptionsController < ApplicationController
  def new
    @user = User.find(session[:user_id])
    @subscription = Subscription.new
  end


  def create
    @user = User.find(session[:user_id])
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save_with_payment
      redirect_to edit_user_path(current_user), :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end
end
