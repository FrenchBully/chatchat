class ConversationsController < ApplicationController
  before_filter :authenticate_user!
 
  layout false
 
  def create
    # look for conversation
    # our case we find the conversation 
    # based on event id from meetups
    # create it if it doesn't exist
    if Conversation.existing_conversation(params[:meetup_id],params[:category]).present?
      @conversation = Conversation.existing_conversation(params[:meetup_id],params[:category])
    else
      # makes a conversation with key values of sender and recipient ids
      @conversation = Conversation.create!(conversation_params)
    end
 
    render json: { conversation_id: @conversation.id }
  end
 
  def show
    @conversation = Conversation.find(params[:id])

    # message with
    # @reciever = interlocutor(@conversation)

    @messages = @conversation.messages
    @message = Message.new
  end
 
  private
  # returns {"sender_id": "x", "recipient_id": "y"}
  def conversation_params
    # params.permit(:sender_id, :recipient_id)
    params.permit(:meetup_id, :category)
  end
 
  def interlocutor(conversation)
    # current_user ? conversation.sender : conversation.recipient
  end
end
