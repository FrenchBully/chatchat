var ready = function () {
    
    // On click open conversation 
    // $('.start-chat').click(function (e) {
        
    // });
 

    // Minimizes chat box, cid = @chat.id from view
    $(document).on('click', '.toggleChatBox', function (e) {
        e.preventDefault();
        
        var id = $(this).data('cid');
        chatBox.toggleChatBoxGrowth(id);
    });
 
    // Close chat box 
    $(document).on('click', '.closeChat', function (e) {
        e.preventDefault();
        var id = $(this).data('cid');
        $.post("/unsubscribe/" + id, {}, function (data) {    
            chatBox.close(id);
        });
    });
 
    // On key down in chat input text area
    // Call checkInputKey in chat.js
    $(document).on('keydown', '.chatboxtextarea', function (event) {
 
        var id = $(this).data('cid');
        chatBox.checkInputKey(event, $(this), id);
    });
 
    /**
     * When a chat link is clicked show up the respective
     * chat chatbox
     */
    // $('a.chat').click(function (e) {
    //     e.preventDefault();
 
    //     var chat_id = $(this).data('cid');
    //     chatBox.chatWith(chat_id);
    // });
 
 
}
 
$(document).ready(ready);
$(document).on("page:load", ready);