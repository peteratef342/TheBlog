$('.accept-btn').click(function() {

	var btn = $(this)
	var requestId = btn.data('request-id')
	

	$.ajax({
    type: "POST",
    url: '/follow',
    data:
    {
        userFollower : {request_id: requestId}
    }
	})
	.done(function( msg )
        {
	    	var div = $('#request-div-' + requestId)
	    	div.remove()

		})
    .fail(function( msg )
     	{
		    alert("something wrong with this request")	
        	location.reload()
		});
		
})