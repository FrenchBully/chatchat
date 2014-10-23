var ready = function () {
 

    // On click open conversation 
    $('.start-chat').click(function (e) {
        e.preventDefault();
        console.log("starting chat box");
        



        // grabs data out of the item that was clicked which is setup through html tags
        var category = $(this).data('category');  
        var event_id = $(this).data('event_id');
 
        $.post("/chats", { category: category, event_id: event_id }, function (data) {
            // console.log(data);
            console.log("posted to create/found chat");
            chatBox.chatWith(data.chat_id);

            $.post("/chats/"+data.chat_id+"/messages", {message: {join_chat: true}}, function(data){
            
            });
        });
    });
 

    // Minimizes chat box, cid = @chat.id from view
    // $(document).on('click', '.toggleChatBox', function (e) {
    //     e.preventDefault();
 
    //     var id = $(this).data('cid');
    //     chatBox.toggleChatBoxGrowth(id);
    // });
 
    // Close chat box 
    $(document).on('click', '.closeChat', function (e) {
        e.preventDefault();
 

        // Post to chat alert controller
        // generate create.js.erb with DOM modifiers

        

        var id = $(this).data('cid');
        console.log("posting");
        $.post("/chats/"+id+"/messages", {message: {left_chat: true}}, function(data){
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
 
// $(document).ready(ready);
$(document).on("page:load", ready);