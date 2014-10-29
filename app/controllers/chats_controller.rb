class ChatsController < ApplicationController
  before_filter :authenticate_user!
  
  layout false
  
  def create
    # look for chat
    # based on event id from meetups
    # create it if it doesn't exist

    if Chat.existing_chat(params[:event_id],params[:category]).present?
      @chat = Chat.existing_chat(params[:event_id],params[:category])

      # if user never joined this chat add user to chat (ChatUser join table)
      if !@chat.users.include?(current_user)
        ChatUser.create(user_id: current_user.id, chat_id: @chat.id)
      end

    else
      # makes a chat with key values of sender and recipient ids
      @chat = Chat.create!(chat_params)
      # adds user to chat (ChatUser join table)
      ChatUser.create(user_id: current_user.id, chat_id: @chat.id)
    end

    # return this as data in ajax request, chat id, name, user (later two for heading)
    render json: { chat_id: @chat.id, chat_name: params[:category], user_count: @chat.users.count}
  end
  
  def show
    @chat = Chat.find(params[:id])
    # message with
    # @reciever = interlocutor(@chat)
    @messages = @chat.messages
    # sets input field for new message
    @message = Message.new
    # @user = User.find(params[:id])
  end

  def leavechat
    @chat = Chat.find(params[:id])
  end

  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    render nothing: true
  end
  
  private
  # returns {"sender_id": "x", "recipient_id": "y"}
  def chat_params
    # params.permit(:sender_id, :recipient_id)
    params.permit(:event_id, :category)
  end
  
  # def interlocutor(chat)
    # current_user ? chat.sender : chat.recipient
  # end
end
