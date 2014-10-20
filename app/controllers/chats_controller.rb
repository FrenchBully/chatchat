class ChatsController < ApplicationController
  before_filter :authenticate_user!
  
  layout false
  
  def create
    # look for chat
    # our case we find the chat 
    # based on event id from meetups
    # create it if it doesn't exist
    if chat.existing_chat(params[:event_id],params[:category]).present?
      @chat = chat.existing_chat(params[:event_id],params[:category])
    else
      # makes a chat with key values of sender and recipient ids
      @chat = chat.create!(chat_params)
    end
  
    render json: { chat_id: @chat.id }
  end
  
  def show
    @chat = chat.find(params[:id])

    # message with
    # @reciever = interlocutor(@chat)

    @messages = @chat.messages
    @message = Message.new
  end
  
  private
  # returns {"sender_id": "x", "recipient_id": "y"}
  def chat_params
    # params.permit(:sender_id, :recipient_id)
    params.permit(:event_id, :category)
  end
  
  def interlocutor(chat)
    # current_user ? chat.sender : chat.recipient
  end
end
