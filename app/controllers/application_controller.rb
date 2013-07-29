class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_login
  before_filter :require_subscription

  def require_subscription
    if current_user.subscription == nil
      redirect_to edit_user_path(current_user.id), :alert => "Messages are for Premium users only."
    end
  end


  protected
  def not_authenticated
    redirect_to login_path, :alert => "Please login first."
  end
end
