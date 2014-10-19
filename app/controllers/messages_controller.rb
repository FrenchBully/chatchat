class MessagesController < ApplicationController
  before_filter :authenticate_user!
 
  def create
    @conversation = Conversation.find(params[:conversation_id])
    # message_params gets the text to be passed 
    @message = @conversation.messages.new(message_params)
    @message.user_id = current_user.id
    @message.save!
 
    @path = conversation_path(@conversation)
    # executes create.js.erb file
    # which uses faye to publish(push) to the channel the 
    # new message
  end
 
  private
 
  def message_params
    params.require(:message).permit(:body)
  end
end