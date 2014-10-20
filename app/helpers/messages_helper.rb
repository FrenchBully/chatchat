module MessagesHelper
  def self_or_other(message)
    # checks to see if the user is self or other
    message.user == current_user ? "self" : "other"
  end
 
  def message_interlocutor(message)
    # add who's email to id chat
    message.user
    # message.user == message.conversation.sender ? message.conversation.sender : message.conversation.recipient
  end
end