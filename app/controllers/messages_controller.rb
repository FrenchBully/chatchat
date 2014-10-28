class MessagesController < ApplicationController
  before_filter :authenticate_user!
 
  def create    
    
    @chat = Chat.find(params[:chat_id])
    # message_params gets the text to be passed 
    @message = @chat.messages.new(message_params)
    

    # pass in data to find hash tags, event_id is needed to generate hashtag link
    @message.body = @message.find_hash_tags(@message.body, current_user.event_id)
    @message.user_id = current_user.id
    @message.save!
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