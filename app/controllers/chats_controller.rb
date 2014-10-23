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
    
    render json: { chat_id: @chat.id }
  end
  
  def show
    binding.pry
    @chat = Chat.find(params[:id])
    # message with
    # @reciever = interlocutor(@chat)
    @messages = @chat.messages
    # sets input field for new message
    @message = Message.new


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
