class Message < ActiveRecord::Base
  belongs_to :chat
  belongs_to :user

  validates_presence_of :body, :chat_id, :user_id

  def find_hash_tags (message, event_id)

    # look for hashtag and regular characters following hashtag
    hashtags = message.scan(/#\w+/)

    # if there are no hashtags
    if hashtags == []
      return message

    else # if there are hashtags
      hashtags_removed_arr = message.split(/#\w+/)
      
      # makes hashtags into links for new chat rooms
      hashtags.map! do |hashtag|
        "<a class=" + '"' + "hashtag start-chat" + '"' + "data-category=" + '"' + hashtag + '"' + "data-event_id=" + '"' + event_id.to_s + '"' + "href=" + '"' + "#" + '"' + ">" + hashtag + "</a>"
      end

      # add linked hashtags back in to message
      hashtags_removed_arr.each_with_index do |item, index|
        
        # in case the last part of array is empty
        if hashtags[index] != nil
          item << hashtags[index]
        end
      end
      
      # if all they put is a hashtag without text
      if hashtags_removed_arr == []
        hashtags_removed_arr = hashtags
      end

      # recombine the message
      hashtags_removed_arr = hashtags_removed_arr.join
      return hashtags_removed_arr
    end    
  end
end
