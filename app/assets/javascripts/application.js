// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
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
//= require ckeditor/init
//= require select2-full
//  require_tree 

$(document).ready(function() {


	$('.follow-btn').click(function() {

		var profileId = $(this).data('profile-id')
		var Btn = $(this)
		var status = Btn.data('status')

		if(status === "follow"){

			$.ajax({
		    type: "POST",
		    url: '/followRequest',
		    data:
		    {
		        FollowRequest : {request_followee_id: profileId}
		    }
	    	})
	    	.done(function( msg )
		        {
			    	var requestBtn = $('#request-follow-btn')
					Btn.hide()
					requestBtn.show()
		        })
	        .fail(function( msg )
		        {
		        	alert("some thing go wrong " + msg)
				});
			
		}else if(status === "request"){

			$.ajax({
		    type: "DELETE",
		    url: '/followRequest',
		    data:
		    {
		        FollowRequest : {request_followee_id: profileId }
		    }
	    	}).done(function( msg )
		        {

			    	var follow = $('#follow-btn')
			    	Btn.hide()
			    	follow.show()
			    	location.reload()
				})
	        .fail(function( msg )
		     	{
		        	alert("something wrong with this request")	
				});



		}else if( status === "unfollow"){
			
			$.ajax({
		    type: "DELETE",
		    url: '/follow',
		    data:
		    {
		        userFollower : {followee_id: profileId }
		    }
	    	}).done(function( msg )
		        {

			    	var follow = $('#follow-btn')
			    	Btn.hide()
			    	follow.show()
			    	location.reload()
				})
	        .fail(function( msg )
		     	{
		        	alert("some thing go wrong " + msg)
					
				});
			
		}
	})
	

})


