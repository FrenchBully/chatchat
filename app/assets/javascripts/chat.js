/**
 * Chat logic
 *
 * Most of the js functionality is inspired from anatgarg.com
 * jQuery tag Module from the tutorial
 * http://anantgarg.com/2009/05/13/gmail-facebook-style-jquery-chat/
 *
 */
 
 
var chatboxFocus = new Array();
var chatBoxes = new Array();
// var chattys = new Array();
 
var ready = function () {
 
    chatBox = {
 
        /**
         * creates an inline chatbox on the page by calling the
         * createChatBox function passing along the unique chat_id
         * 
         * @param chat_id
         */
 
        chatWith: function (chat_id) {
 
            chatBox.createChatBox(chat_id);
            $("#chatbox_" + chat_id + " .chatboxtextarea").focus();
        },
 
        /**
         * closes the chatbox by essentially hiding it from the page
         * 
         * @param chat_id
         */
 
        close: function (chat_id) {
            $('#chatbox_' + chat_id).css('display', 'none');
            // chatBox.restructure();
        },
 
        /**
         * Plays a notification sound when a new chat message arrives
         */
 
        // notify: function () {
            // var audioplayer = $('#chatAudio')[0];
            // audioplayer.play();
        // },
 
        /**
         * Handles 'smart layouts' of the chatboxes. Like when new chatboxes are
         * added or removed from the view, it restructures them so that they appear
         * neatly aligned on the page
         */
    
        // for lining up chat boxes
        restructure: function () {
            align = 0;
            for (x in chatBoxes) {
                chatbox_id = chatBoxes[x];
 
                if ($("#chatbox_" + chatbox_id).css('display') != 'none') {
                    if (align == 0) {
                        $("#chatbox_" + chatbox_id).css('right', '20px');
                    } else {
                        width = (align) * (280 + 7) + 20;
                        $("#chatbox_" + chatbox_id).css('right', width + 'px');
                    }
                    align++;
                }
            }
 
        },
 
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
            
            if ($("#chatbox_" + chat_id).length > 0) {
                if ($("#chatbox_" + chat_id).css('display') == 'none') {
                    $("#chatbox_" + chat_id).css('display', 'block');
                    chatBox.restructure();
                }
                $("#chatbox_" + chat_id + " .chatboxtextarea").focus();
                return;
            }
            
            // adds chatbox with unique id
            $("body").append('<div id="chatbox_' + chat_id + '" class="chatbox"></div>')
            
            console.log("getting the chat show template");
            
            $.get("chats/" + chat_id, function (data) {
                // the data returned here is the chatbox with all info
                // unique id added on plus chatboxcontent class added
                console.log("got chat data");
                $('#chatbox_' + chat_id).html(data);
                $("#chatbox_" + chat_id + " .chatboxcontent").scrollTop($("#chatbox_" + chat_id + " .chatboxcontent")[0].scrollHeight);
            }, "html");
            
            $("#chatbox_" + chat_id).css('bottom', '0px');
 
            chatBoxeslength = 0;
 
            for (x in chatBoxes) {
                if ($("#chatbox_" + chatBoxes[x]).css('display') != 'none') {
                    chatBoxeslength++;
                }
            }
 
            if (chatBoxeslength == 0) {
                $("#chatbox_" + chat_id).css('right', '20px');
            } else {
                width = (chatBoxeslength) * (280 + 7) + 20;
                $("#chatbox_" + chat_id).css('right', width + 'px');
            }
 
            chatBoxes.push(chat_id);
 
            if (minimizeChatBox == 1) {
                minimizedChatBoxes = new Array();
 
                if ($.cookie('chatbox_minimized')) {
                    minimizedChatBoxes = $.cookie('chatbox_minimized').split(/\|/);
                }
                minimize = 0;
                for (j = 0; j < minimizedChatBoxes.length; j++) {
                    if (minimizedChatBoxes[j] == chat_id) {
                        minimize = 1;
                    }
                }
 
                if (minimize == 1) {
                    $('#chatbox_' + chat_id + ' .chatboxcontent').css('display', 'none');
                    $('#chatbox_' + chat_id + ' .chatboxinput').css('display', 'none');
                }
            }
 
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
 
        /**
         * Responsible for listening to the keypresses when chatting. If the Enter button is pressed,
         * we submit our chat form to our rails app
         *
         * @param event
         * @param chatboxtextarea
         * @param chat_id
         */
 
        checkInputKey: function (event, chatboxtextarea, chat_id) {
            if (event.keyCode == 13 && event.shiftKey == 0) {
                event.preventDefault();
 
                message = chatboxtextarea.val();
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
 
        },
 
        /**
         * Responsible for handling minimize and maximize of the chatbox
         *
         * @param chat_id
         */
 
        toggleChatBoxGrowth: function (chat_id) {
            // chattys.push(chat_id);
            // console.log(chattys);
            // if ($('#chatbox_' + chat_id + ' .chatboxcontent').css('display') == 'none') {
            //     console.log("minimized");
            //     console.log($.cookie('chatbox_minimized'));
            //     var minimizedChatBoxes = new Array();
 
            //     if ($.cookie('chatbox_minimized')) {
            //         minimizedChatBoxes = $.cookie('chatbox_minimized').split(/\|/);
            //     }
 
            //     var newCookie = '';
 
            //     for (i = 0; i < minimizedChatBoxes.length; i++) {
            //         if (minimizedChatBoxes[i] != chat_id) {
            //             newCookie += chat_id + '|';
            //         }
            //     }
 
            //     newCookie = newCookie.slice(0, -1)
 
 
            //     $.cookie('chatbox_minimized', newCookie);
            //     $('#chatbox_' + chat_id + ' .chatboxcontent').css('display', 'block');
            //     $('#chatbox_' + chat_id + ' .chatboxinput').css('display', 'block');
            //     $("#chatbox_" + chat_id + " .chatboxcontent").scrollTop($("#chatbox_" + chat_id + " .chatboxcontent")[0].scrollHeight);
            // } else {
 
            //     var newCookie = chat_id;
 
            //     if ($.cookie('chatbox_minimized')) {
            //         newCookie += '|' + $.cookie('chatbox_minimized');
            //     }
 
 
            //     $.cookie('chatbox_minimized', newCookie);
            //     $('#chatbox_' + chat_id + ' .chatboxcontent').css('display', 'none');
            //     $('#chatbox_' + chat_id + ' .chatboxinput').css('display', 'none');
            // }
 
        }
 
 
 
    }
 
 
    /**
     * Cookie plugin
     *
     * Copyright (c) 2006 Klaus Hartl (stilbuero.de)
     * Dual licensed under the MIT and GPL licenses:
     * http://www.opensource.org/licenses/mit-license.php
     * http://www.gnu.org/licenses/gpl.html
     *
     */
 
    jQuery.cookie = function (name, value, options) {
        // if (typeof value != 'undefined') { // name and value given, set cookie
        //     options = options || {};
        //     if (value === null) {
        //         value = '';
        //         options.expires = -1;
        //     }
        //     var expires = '';
        //     if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
        //         var date;
        //         if (typeof options.expires == 'number') {
        //             date = new Date();
        //             date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
        //         } else {
        //             date = options.expires;
        //         }
        //         expires = '; expires=' + date.toUTCString(); // use expires attribute, max-age is not supported by IE
        //     }
        //     // CAUTION: Needed to parenthesize options.path and options.domain
        //     // in the following expressions, otherwise they evaluate to undefined
        //     // in the packed version for some reason...
        //     var path = options.path ? '; path=' + (options.path) : '';
        //     var domain = options.domain ? '; domain=' + (options.domain) : '';
        //     var secure = options.secure ? '; secure' : '';
        //     document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
        // } else { // only name given, get cookie
        //     var cookieValue = null;
        //     if (document.cookie && document.cookie != '') {
        //         var cookies = document.cookie.split(';');
        //         for (var i = 0; i < cookies.length; i++) {
        //             var cookie = jQuery.trim(cookies[i]);
        //             // Does this cookie string begin with the name we want?
        //             if (cookie.substring(0, name.length + 1) == (name + '=')) {
        //                 cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
        //                 break;
        //             }
        //         }
        //     }
        //     return cookieValue;
        // }
    };
 
 
}
 
$(document).ready(ready);
$(document).on("page:load", ready);