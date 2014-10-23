class MessagesController < ApplicationController
  before_filter :authenticate_user!
 
  def create
    @chat = Chat.find(params[:chat_id])




    # message from user
    if params[:message][:body]
      # message_params gets the text to be passed 
      @message = @chat.messages.new(message_params)
      @message.user_id = current_user.id
      @message.save!
    
    # leaving chat
    elsif params[:message][:left_chat] == "true"
      @message = @chat.messages.new({body: "#{current_user.name} has left the chat"})
      @message.save!
      # @message = @chat.messages.new()
      # @message.user_id = current_user.id

    # joining chat
    else
      @message = @chat.messages.new({body: "#{current_user.name} has joined the chat"})
      @message.save!
   
    end
    
    @path = chat_path(@chat)
    # path is chats/:id to show chat
    # executes create.js.erb file
    # which uses faye to publish(push) to the channel the 
    # new message
  end
 
  private
 
  def message_params
    params.require(:message).permit(:body)
  end

end