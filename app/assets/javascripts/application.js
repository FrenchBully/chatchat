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

// $(document).ready(ready);
// $(document).on('page:load', ready);

$( document ).ready(function(){

		function getLocation() {
		    if (navigator.geolocation) {
		    	$(".detecting-location").show();
		    	$("#devise-links").hide();
		        navigator.geolocation.getCurrentPosition(showPosition);
		    } 
		}

		function showPosition(position) {
			$("#lat").val(position.coords.latitude);
			$("#lon").val(position.coords.longitude);
			console.log("location logged");
			$(".detecting-location").hide();
			$("#devise-links").show();
		}
		getLocation();
		// $("#meetup-auth").click(getLocation());

		$("#interests").keypress(function(e) {
			if(e.which == 13) {
		        // alert('You pressed enter!');
		    }
		})
});
    


