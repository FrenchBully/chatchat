var ready = function () {
    
    // On key down in chat input text area
    // Call checkInputKey in chat.js
    $(document).on('keydown', '.chatboxtextarea', function (event) {
        var id = $(this).data('cid');
        chatBox.checkInputKey(event, $(this), id);
    });

    // for the submit message button
    $(document).delegate('.click-to-send-message', 'click', function(event){
        event.preventDefault();
        var id = $(this).data('cid');
        
        // get input field
        chatBox.sendMessage($('#chat_input_'+id), id);
    }); 
}
 
$(document).ready(ready);
$(document).on("page:load", ready);