var ready = function () {
 
    /**
     * When the send message link on our home page is clicked
     * send an ajax request to our rails app with the sender_id and
     * recipient_id
     */
 
    $('.start-conversation').click(function (e) {
        e.preventDefault();
        console.log(e.preventDefault);
        
        
        // grabs data out of the item that was clicked which is setup through html tags
        
        
        var category = $(this).data('category');

        
        var meetup_id = $(this).data('meetup_id');
 
        $.post("/conversations", { category: category, meetup_id: meetup_id }, function (data) {
            console.log(data);
            console.log("posted to create");
            chatBox.chatWith(data.conversation_id);
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
     * When a conversation link is clicked show up the respective
     * conversation chatbox
     */
 
    $('a.conversation').click(function (e) {
        e.preventDefault();
 
        var conversation_id = $(this).data('cid');
        chatBox.chatWith(conversation_id);
    });
 
 
}
 
$(document).ready(ready);
$(document).on("page:load", ready);