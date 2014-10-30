class ChatsController < ApplicationController
  
  before_filter :authenticate_user!
  
  layout false
  
  def create

    # look for chat based on event id from meetups create it if it doesn't exist
    # users can't have more than 5 chats
    if current_user.chats.count < 5 
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
      render json: { chat_id: @chat.id, chat_name: params[:category], user_count: @chat.users.count, event_name: @chat.event.name[0..15]}
    else
      # checks if chat is already existing, then render that chat if user already belongs to
      if Chat.existing_chat(params[:event_id],params[:category]).present?
        @chat = Chat.existing_chat(params[:event_id],params[:category])
        render json: { chat_id: @chat.id, chat_name: params[:category], user_count: @chat.users.count, event_name: @chat.event.name[0..15]}
      else
      # render main chat if user is maxed out on number of chats
        render json: { chat_id: current_user.chats.first.id, chat_name: "main", users_count: current_user.chats.first.users.count, event_name: current_user.event.name[0..15]}
      end
    end
  end
  
  def show
    # find chat and chat's messages and instantiate new message for form
    @chat = Chat.find(params[:id])
    @messages = @chat.messages
    @message = Message.new
  end

  def leavechat
    @chat = Chat.find(params[:id])
  end

  def destroy
    # find that chat user relation and destroy it
    current_user.chat_users.find_by(chat_id: params[:id]).destroy
    render nothing: true
  end

  # update menu
  def event_update 
    @user = current_user
    @users = get_current_users   
  end

  def get_current_users
    @users = []
    Chat.find_by(event_id: current_user.event_id, category: "main").users.each do |u|
      @users << u
    end
      return @users
  end
  
  private

  def chat_params
    params.permit(:event_id, :category)
  end

end
