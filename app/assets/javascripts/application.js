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
//= require bootstrap-sprockets

//= require chat

//= require private_pub


//= require turbolinks
//= require_tree .


// var ready = function() {

// 	function getLocation() {
// 		console.log("yo")
// 		alert("getLocation");
// 	    navigator.geolocation.getCurrentPosition(showPosition);
// 	}

// 	function showPosition(position) {
// 		alert("duhhhh");
// 	    $('#lat').val(position.coords.latitude); 
// 	    $('#lon').val(position.coords.longitude); 
// 	}
// };


var ready = function(){


		$(window).load(function() {
		$('#welcome-container').css('height', window.innerHeight+'px');
		});

		$(window).resize(function() {
		$('#welcome-container').css('height', window.innerHeight+'px');
		});

		$('#scroll-down').click(function() {
			// e.preventDefault();
			$(this).parent().append( "<div id='about-text'><h1>About</h1>Tired of having the same old conversations with the wrong people? MetaMeetup helps people connect with the right people at Meetup.com events. Sign into MetaMeetup when you arrive and spend your time wisely. <br><br>Don't yet have a meetup.com account? Sign up for one <a href='http://meetup.com'>here</a><br><br>MetaMeetup was created by Andy Chen, Kevin Ng, and Ran Craycraft in the heart of Silicon Beach.</div>" );
		    // $.post(this.href, { _method: 'delete' }, null, "script");
    		$('html, body').animate({
		        scrollTop: $("#about-text").offset().top
		    }, 1000);
		    $('#scroll-down').hide();
		});

		$('.close').click(function(){
				$(this).parent().parent().hide();
		})

		function getLocation() {
		    if (navigator.geolocation) {
		    	$(".detecting-location").show();
		    	$("#start-chat").hide();
		        navigator.geolocation.getCurrentPosition(showPosition);
		    } 
		}

		function showPosition(position) {
			$("#lat").val(position.coords.latitude);
			$("#lon").val(position.coords.longitude);
			// console.log(position.coords.latitude, position.coords.longitude);
			$(".detecting-location").hide();
			 $("#start-chat").show();
		}
		// getLocation();
		// $("#meetup-auth").click(getLocation());

		getLocation();

		$("#interests").keypress(function(e) {
			if(e.which == 13) {
		        // alert('You pressed enter!');
		    }
		})
		$(".notice").click(function(){
			$(this).hide();
		});

		$(".alert").click(function(){
			$(this).hide();
		});

		$("#interests-field").keypress(function(e) {
			if(e.which == 13) {
		        e.preventDefault();
		        $.ajax({
		        	type: "POST",
		        	url: "/save_interest",
		        	data: {interest: $("#interests-field").val().replace(/[^a-z0-9\s]/gi, '').toLowerCase() }
		        }).done(function(response){
		        	// console.log(response);
		        	if (!response.error){
		        		$("#my-interests").append("<li class='interest'><a class='button remote-delete green' href='/interests/" + response.id + "'>" + "#" + response.name + "</a></li>")
		        	}
		        })

		        $("#interests-field").val("")
		        // add some innerhtml to make a new button appear
		        
		    }
		});
		
		$('.interest-cloud').on("click", "li.interest a.remote-delete", function(e) {
			e.preventDefault();
			$(this).parent().hide();
		    $.post(this.href, { _method: 'delete' }, null, "script");
		});

		// I'm not sure this one works...
		$('.interest-cloud').on("click", "li.interest a.remote-add", function(e) {
			e.preventDefault();
			$.ajax({
	        	type: "POST",
	        	url: "/save_interest",
	        	data: {interest: $("a.remote-add").val() }
	        }).done(function(response){
	        	if (!response.error){
	        		$("#my-interests").append("<li class='interest'><a class='button remote-delete ' href='/interests/" + response.id + "'>" + " " + response.name + "</a></li>")
	        	}
	        })
		});

		$(".main-menu").on("click", function(e){  

		  var distance = $('#site').css('left');  
    
		  if(distance == "auto" || distance == "0px") {  
		   $("#navigation li a").addClass("open");  
		   openSidepage();  
		  } else {  
		   closeSidepage();  
		  }  
		});

		// hide menu when chat room is clicked
		$(".hide-menu").on("click", function(e){
			closeSidepage();
		});

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
    

 
$(document).ready(ready);
$(document).on("page:load", ready);

