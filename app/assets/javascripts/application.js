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

$(document).ready(ready);
$(document).on('page:load', ready);

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
		$(".notice").click(function(){
			$(this).hide();
		});

		$(".alert").click(function(){
			$(this).parent.hide();
		});

		$("#interests-field").keypress(function(e) {
			if(e.which == 13) {
		        e.preventDefault();
		        $.ajax({
		        	type: "POST",
		        	url: "/save_interest",
		        	data: {interest: $("#interests-field").val() }
		        }).done(function(response){
		        	$(".interest-cloud").append("<li class='interest'><a class='button remote-delete' href='/interests/" + response.id + "'>" + response.name + " X" + "</a></li>")
		        })

		        $("#interests-field").val("")
		        // add some innerhtml to make a new button appear
		        
		    }
		});
		
		$('.interest-cloud').on("click", "li.interest a.remote-delete", function(e) {
			e.preventDefault();
			$(this).parent().hide();
		    $.post(this.href, { _method: 'delete' }, null, "script");
			console.log(this.href)
		});

});
    


