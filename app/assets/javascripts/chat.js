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
            console.log("creating chat");
            
            // adds chatbox with unique id to site div
            $("#site").append('<div id="chatbox_' + chat_id + '" class="chatbox"></div>')
            
            console.log("getting the chat template");
            
            $.get("/chats/" + chat_id, function (data) {
                // the data returned here is the chatbox with all info
                // unique id added on plus chatboxcontent class added
                console.log("got chat data");
                $('#chatbox_' + chat_id).html(data);
                $("#chatbox_" + chat_id + " .chatboxcontent").scrollTop($("#chatbox_" + chat_id + " .chatboxcontent")[0].scrollHeight);
            }, "html");
            
            // chatBoxes refers to array of present chat_boxes
            chatBoxes.push(chat_id);

            // make all other chat boxes except chat_id disappear
            for (x in chatBoxes) {
                // if that chat box was clicked show otherwise hide
                if(chatBoxes[x] == chat_id){
                    $("#chatbox_" + chatBoxes[x]).css('display', 'block');
                    // $("#chatbox_" + chatBoxes[x]).fadeIn();
                    // switch out header info
                    var newHeader = chat_name + " - " + event_name;
                    $(".page-title").text(newHeader.substring(0,24)+" (" + user_count + ")");
                }
                else{
                    // $("#chatbox_" + chatBoxes[x]).css('display', 'none');
                    $("#chatbox_" + chatBoxes[x]).remove();

                }
            }
        },
        
        // checks input box for enter key
        checkInputKey: function (event, chatboxtextarea, chat_id) {

            // when u go to a new line using shift enter don't submit
            // otherwise execute this
            if (event.keyCode == 13 && event.shiftKey == 0) {
                event.preventDefault();
                // console.log(event.shiftKey);
            
                message = chatboxtextarea.val();
                // empty input field
                message = message.replace(/^\s+|\s+$/g, "");
 
                if (message != '') {
                    $('#chat_form_' + chat_id).submit();
                    $(chatboxtextarea).val('');
                    $(chatboxtextarea).focus();
                    // $(chatboxtextarea).css('height', '44px');
                }
            }
        },

        // send message via button
        sendMessage: function (chatboxtextarea, chat_id) {
            message = chatboxtextarea.val();
            
            // empty input field
            message = message.replace(/^\s+|\s+$/g, "");

            if (message != '') {
                $('#chat_form_' + chat_id).submit();
                $(chatboxtextarea).val('');
                $(chatboxtextarea).focus();
            }
            
            // if it isn't empty
            else{
                $(chatboxtextarea).focus();
            }
        }
    }
}
 
$(document).ready(ready);
$(document).on("page:load", ready);