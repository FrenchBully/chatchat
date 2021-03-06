// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require chat
//= require private_pub
//= require turbolinks
//= require_tree .

var ready = function(){

	// hides chatrooms from view when the user clicks X
	$(document).delegate(".close", "click", function (e) {
				e.preventDefault();
			$(this).parent().parent().hide();
	});

	// detect geolocation of user and display gif until coordinates are saved
	function getLocation() {
	    if (navigator.geolocation) {
	    	$(".detecting-location").show();
	    	$("#start-chat").hide();
	        navigator.geolocation.getCurrentPosition(showPosition);
	    } 
	}

	// post the coordinates into a hidden field on the edit profile page
	function showPosition(position) {
		$("#lat").val(position.coords.latitude);
		$("#lon").val(position.coords.longitude);
		$(".detecting-location").hide();
		 $("#start-chat").show();
	}

	// get the user's location on startup
	getLocation();

	// hide notice and alert on clicks
	$(".notice").click(function(){
		$(this).hide();
	});

	$("#alert").click(function(){
		$(this).hide();
	});

	// allows user to set interests dynamically in user edit page
	$("#interests-field").keypress(function(e) {
		if(e.which == 13) {

			// dont' submit the whole form on keypress
	        e.preventDefault();

	        // submit the form via ajax post request
	        $.ajax({
	        	type: "POST",
	        	url: "/save_interest",

	        	// the value in the text box should be passed in via 'data'...strip out bad characters
	        	data: {interest: $("#interests-field").val().replace(/[^a-z0-9\s]/gi, '').toLowerCase() }
	        }).done(function(response){
	        	
	        	// if the response is not an error, then display the interest in a button so refresh is not needed
	        	if (!response.error){
	        		$("#interests-field").val('');
	        		$("#my-interests").append("<li class='interest'><a class='button remote-delete green' href='/interests/" + response.id + "'>" + "#" + response.name + "</a></li>")
	        	}
	        	$("#interests-field").val('');
	        })	        
	    }
	});
	
	// Allows user to remove interest from their profile 
	$('.interest-cloud').on("click", "li.interest a.remote-delete", function(e) {
		e.preventDefault();
		$(this).parent().hide();
	    $.post(this.href, { _method: 'delete' }, null, "script");
	});

	// toggle the main menu when you click the menu icon
	$(".main-menu").on("click", function(e){  
	    var distance = $('#site').css('left');  
	    if (distance == "auto" || distance == "0px") {  
	    	$("#navigation li a").addClass("open");  
	   		openSidepage();  
	  	} else {  
	   		closeSidepage();  
	  	}  
	});

	

	// animation functions
	function openSidepage() {  
		$('#site').animate({  
	  		left: '250px'  
	 	}, "fast");   
	}  

	function closeSidepage() { 
		$("#navigation li a").removeClass("open");  
	 	$('#site').animate({  
	  		left: '0px'  
	 	}, "slow");   
	} 
};

// to know when the page is loaded 
$(document).ready(ready);
$(document).on("page:load", ready);