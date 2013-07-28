class MessagesController < ApplicationController
  def index
    #Goal: find all users that current logged in user has had contact with
    conversation_partner_ids = []

    # Find all messages sent to or sent by the current logged in user
    sent_messages = Message.where(:sender_id => current_user.id)
    received_messages = Message.where(:receiver_id => current_user.id)

    # Find unique receiver ids of messages sent by current user
    sent_messages.each do |message|
      if !conversation_partner_ids.include?(message.receiver_id)
        conversation_partner_ids << message.receiver_id
      end
    end

    # Find unique sender ids of messages received by current user (taking into account the above loop)
    received_messages.each do |message|
      if !conversation_partner_ids.include?(message.sender_id)
        conversation_partner_ids << message.sender_id
      end
    end

    # Find the user record of the associated ids gathered above
    conversation_partners = []

    conversation_partner_ids.each do |user_id|
      conversation_partners << User.find(user_id)
    end

    # create instance variable to use in views
    @conversation_partners = conversation_partners

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def new
    @conversation_partner = User.find(params[:user_id])
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  def create
    @message = current_user.sent_messages.create(params[:message])

    respond_to do |format|
      if @message.save

        @conversation_partner = User.find(params[:message][:receiver_id])

        messages = []

        sent_messages = current_user.sent_messages.where(:receiver_id => @conversation_partner.id)
        received_messages = current_user.received_messages.where(:sender_id => @conversation_partner.id)

        sent_messages.each do |message_by_current_user|
          messages << message_by_current_user
        end

        received_messages.each do |message_to_current_user|
          messages << message_to_current_user
        end

        # Sort relevant conversations by date
        @messages = messages.sort {
          |a, b| b.created_at <=> a.created_at
        }


        format.html { redirect_to message_path(message.receiver_id), notice: 'Message has been sent.' }
        format.js
      else
        format.html { render action: "new" }
        format.js
      end
    end
  end

  def show
    # For displaying new message form
    @message = Message.new

    #Goal: Display all messages between current logged in user and chosen conversation partner
    @conversation_partner = User.find(params[:user_id])

    messages = []

    sent_messages = current_user.sent_messages.where(:receiver_id => @conversation_partner.id)
    received_messages = current_user.received_messages.where(:sender_id => @conversation_partner.id)

    sent_messages.each do |message_by_current_user|
      messages << message_by_current_user
    end

    received_messages.each do |message_to_current_user|
      messages << message_to_current_user
    end

    # Sort relevant conversations by date
    @messages = messages.sort {
      |a, b| b.created_at <=> a.created_at
    }

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

end
