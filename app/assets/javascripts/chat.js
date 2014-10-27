/**
 * Chat logic
 *
 * Most of the js functionality is inspired from anatgarg.com
 * jQuery tag Module from the tutorial
 * http://anantgarg.com/2009/05/13/gmail-facebook-style-jquery-chat/
 *
 */
 
// keep track of variables on client side 
var chatboxFocus = new Array();
var chatBoxes = new Array();
 
var ready = function () {
 
    chatBox = {
   
        // Make chatbox by calling createChatBox and adds focus
        chatWith: function (chat_id) {
 
            chatBox.createChatBox(chat_id);
            $("#chatbox_" + chat_id + " .chatboxtextarea").focus();
        },

 
        // close: function (chat_id) {
        //     $('#chatbox_' + chat_id).css('display', 'none');
            // chatBox.restructure();
        // },
 
        /**
         * Plays a notification sound when a new chat message arrives
         */
 
        // notify: function () {
            // var audioplayer = $('#chatAudio')[0];
            // audioplayer.play();
        // },

    
        // for lining up chat boxes
        // restructure: function () {
            // align = 0;
            // for (x in chatBoxes) {
            //     chatbox_id = chatBoxes[x];
 
            //     if ($("#chatbox_" + chatbox_id).css('display') != 'none') {
            //         if (align == 0) {
            //             $("#chatbox_" + chatbox_id).css('right', '20px');
            //         } else {
            //             width = (align) * (280 + 7) + 20;
            //             $("#chatbox_" + chatbox_id).css('right', width + 'px');
            //         }
            //         align++;
            //     }
            // }
 
        // },
 
        /**
         * Takes in two parameters. It is responsible for fetching the specific chat's
         * html page and appending it to the body of our home page e.g if chat_id = 1
         *
         * $.get("chats/1, function(data){
         *    // rest of the logic here
         * }, "html")
         *
         * @param chat_id
         * @param minimizeChatBox
         */
 
        createChatBox: function (chat_id, minimizeChatBox) {
            console.log("creating chat box!!!!");

            // necessary?
            // if ($("#chatbox_" + chat_id).length > 0) {
            //     if ($("#chatbox_" + chat_id).css('display') == 'none') {
            //         $("#chatbox_" + chat_id).css('display', 'block');
            //         // chatBox.restructure();
            //     }
            //     $("#chatbox_" + chat_id + " .chatboxtextarea").focus();
            //     return;
            // }
            
            // adds chatbox with unique id to site div
            $("#site").append('<div id="chatbox_' + chat_id + '" class="chatbox"></div>')
            
            console.log("getting the chat show template");
            
            $.get("/chats/" + chat_id, function (data) {
                // the data returned here is the chatbox with all info
                // unique id added on plus chatboxcontent class added
                console.log("got chat data");
                $('#chatbox_' + chat_id).html(data);
                $("#chatbox_" + chat_id + " .chatboxcontent").scrollTop($("#chatbox_" + chat_id + " .chatboxcontent")[0].scrollHeight);
            }, "html");
            
            // $("#chatbox_" + chat_id).css('bottom', '0px');
 
            chatBoxeslength = 0;

            // for (x in chatBoxes) {
            //     if ($("#chatbox_" + chatBoxes[x]).css('display') != 'none') {
            //         chatBoxeslength++;
            //     }
            // }


            // chatBoxes refers to array of present chat_boxes
            chatBoxes.push(chat_id);

            console.log("numbers of chat boxes "+ chatBoxes);

            // now i make all other chat boxes except chat_id disappear
            for (x in chatBoxes) {
                console.log(chatBoxes[x]);
                // if that chat box was clicked show otherwise hide
                if(chatBoxes[x] == chat_id){
                    $("#chatbox_" + chatBoxes[x]).css('display', 'block');
                }
                else{
                    $("#chatbox_" + chatBoxes[x]).css('display', 'none');
                }
            }

                // this is where you can give the additional chat boxes some property
                // add toggle here
                // if (chatBoxeslength == 0) {
                    // $("#chatbox_" + chat_id).css('right', '20px');
                // } else {
                    // width = (chatBoxeslength) * (280 + 7) + 20;
                    // $("#chatbox_" + chat_id).css('right', width + 'px');
                // }
                
                // this is where it keeps track of chat boxes
                
                // stuff for minizing
                // if (minimizeChatBox == 1) {
                //     minimizedChatBoxes = new Array();
     
                //     if ($.cookie('chatbox_minimized')) {
                //         minimizedChatBoxes = $.cookie('chatbox_minimized').split(/\|/);
                //     }
                //     minimize = 0;
                //     for (j = 0; j < minimizedChatBoxes.length; j++) {
                //         if (minimizedChatBoxes[j] == chat_id) {
                //             minimize = 1;
                //         }
                //     }

                //     if (minimize == 1) {
                //         $('#chatbox_' + chat_id + ' .chatboxcontent').css('display', 'none');
                //         $('#chatbox_' + chat_id + ' .chatboxinput').css('display', 'none');
                //     }
                // }
 
            chatboxFocus[chat_id] = false;
 
            $("#chatbox_" + chat_id + " .chatboxtextarea").blur(function () {
                chatboxFocus[chat_id] = false;
                $("#chatbox_" + chat_id + " .chatboxtextarea").removeClass('chatboxtextareaselected');
            }).focus(function () {
                chatboxFocus[chat_id] = true;
                $('#chatbox_' + chat_id + ' .chatboxhead').removeClass('chatboxblink');
                $("#chatbox_" + chat_id + " .chatboxtextarea").addClass('chatboxtextareaselected');
            });
 
            $("#chatbox_" + chat_id).click(function () {
                if ($('#chatbox_' + chat_id + ' .chatboxcontent').css('display') != 'none') {
                    $("#chatbox_" + chat_id + " .chatboxtextarea").focus();
                }
            });
 
            $("#chatbox_" + chat_id).show();
 
        },
 
        
        // checks input box for enter key
        checkInputKey: function (event, chatboxtextarea, chat_id) {
            if (event.keyCode == 13 && event.shiftKey == 0) {
                event.preventDefault();
 
                message = chatboxtextarea.val();
                // empty input field
                message = message.replace(/^\s+|\s+$/g, "");
 
                if (message != '') {
                    $('#chat_form_' + chat_id).submit();
                    $(chatboxtextarea).val('');
                    $(chatboxtextarea).focus();
                    $(chatboxtextarea).css('height', '44px');
                }
            }
 
            var adjustedHeight = chatboxtextarea.clientHeight;
            var maxHeight = 94;
 
            if (maxHeight > adjustedHeight) {
                adjustedHeight = Math.max(chatboxtextarea.scrollHeight, adjustedHeight);
                if (maxHeight)
                    adjustedHeight = Math.min(maxHeight, adjustedHeight);
                if (adjustedHeight > chatboxtextarea.clientHeight)
                    $(chatboxtextarea).css('height', adjustedHeight + 8 + 'px');
            } else {
                $(chatboxtextarea).css('overflow', 'auto');
            }
 
        }
    }
}
 
$(document).ready(ready);
$(document).on("page:load", ready);