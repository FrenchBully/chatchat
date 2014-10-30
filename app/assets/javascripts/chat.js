// js functionality is inspired from anatgarg.com

// keep track of chatboxes on client side 
var chatBoxes = new Array();
var ready = function () {
    chatBox = {
        // Make chatbox by calling createChatBox and adds focus
        chatWith: function (chat_id, chat_name, user_count, event_name) { 
            chatBox.createChatBox(chat_id, chat_name, user_count, event_name);
        },
        createChatBox: function (chat_id, chat_name, user_count, event_name) {
            // adds chatbox with unique id to site div
            $("#site").append('<div id="chatbox_' + chat_id + '" class="chatbox"></div>')            
            $.get("/chats/" + chat_id, function (data) {
                // the data returned here is the chatbox with all info
                // unique id added on plus chatboxcontent class added
                // chat box data replaced
                $('#chatbox_' + chat_id).html(data);
                $("#chatbox_" + chat_id + " .chatboxcontent").scrollTop($("#chatbox_" + chat_id + " .chatboxcontent")[0].scrollHeight);
            }, "html");
            // chatBoxes array where current chat box selected/created is added to client side var
            chatBoxes.push(chat_id);
            // make all other chat boxes except chat_id disappear
            for (x in chatBoxes) {
                // if that chat box was clicked show otherwise hide
                if(chatBoxes[x] == chat_id){
                    $("#chatbox_" + chatBoxes[x]).css('display', 'block');
                    // switch out header info
                    var newHeader = chat_name + " - " + event_name;
                    $(".page-title").text(newHeader.substring(0,24)+" (" + user_count + ")");
                }
                else{
                    // remove other boxes
                    $("#chatbox_" + chatBoxes[x]).remove();
                }
            }
        },
        // checks input box for enter key
        checkInputKey: function (event, chatboxtextarea, chat_id) {
            // when you go to a new line using shift enter don't submit
            // otherwise execute this
            if (event.keyCode == 13 && event.shiftKey == 0) {
                event.preventDefault();
                // get input field data
                message = chatboxtextarea.val();
                message = message.replace(/^\s+|\s+$/g, "");
                if (message != '') {
                    // submit rails form and replace with empty string
                    $('#chat_form_' + chat_id).submit();
                    $(chatboxtextarea).val('');
                    $(chatboxtextarea).focus();
                }
            }
        },
        // send message via button
        sendMessage: function (chatboxtextarea, chat_id) {
            message = chatboxtextarea.val();
            message = message.replace(/^\s+|\s+$/g, "");
            if (message != '') {
                $('#chat_form_' + chat_id).submit();
                $(chatboxtextarea).val('');
                $(chatboxtextarea).focus();
            }
            else{
                $(chatboxtextarea).focus();
            }
        }
    }
}
 
$(document).ready(ready);
$(document).on("page:load", ready);