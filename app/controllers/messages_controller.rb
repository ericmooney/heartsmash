class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def new
    @receiver = User.find(params[:user_id])
    @message = Message.new(:receiver => @receiver)
  end

  def create
    @message = current_user.sent_messages.create( params[:message] )
    redirect_to(message_path, :message => 'Message has been sent.')
  end

  def show
  end
end
