var ready = function () {
 
    /**
     * When the send message link on our home page is clicked
     * send an ajax request to our rails app with the sender_id and
     * recipient_id
     */
 
    $('.start-chat').click(function (e) {
        e.preventDefault();
        console.log(e.preventDefault);
        
        
        // grabs data out of the item that was clicked which is setup through html tags
        
        
        var category = $(this).data('category');

        
        var event_id = $(this).data('event_id');
 
        $.post("/chats", { category: category, event_id: event_id }, function (data) {
            console.log(data);
            console.log("posted to create");
            chatBox.chatWith(data.chat_id);
        });
    });
 
    /**
     * Used to minimize the chatbox
     */
 
    $(document).on('click', '.toggleChatBox', function (e) {
        e.preventDefault();
 
        var id = $(this).data('cid');
        chatBox.toggleChatBoxGrowth(id);
    });
 
    /**
     * Used to close the chatbox
     */
 
    $(document).on('click', '.closeChat', function (e) {
        e.preventDefault();
 
        var id = $(this).data('cid');
        chatBox.close(id);
    });
 
 
    /**
     * Listen on keypress' in our chat textarea and call the
     * chatInputKey in chat.js for inspection
     */
 
    $(document).on('keydown', '.chatboxtextarea', function (event) {
 
        var id = $(this).data('cid');
        chatBox.checkInputKey(event, $(this), id);
    });
 
    /**
     * When a chat link is clicked show up the respective
     * chat chatbox
     */
 
    $('a.chat').click(function (e) {
        e.preventDefault();
 
        var chat_id = $(this).data('cid');
        chatBox.chatWith(chat_id);
    });
 
 
}
 
$(document).ready(ready);
$(document).on("page:load", ready);