// Get the modal
var modal = document.getElementById('myModal');


$('.show-likes-btn').click(function() {

	var postId = $(this).data('post-id')

	$.ajax({
	    type: "GET",
	    url: '/likes/',
	    dataType: "json",
	    data:
	    {
	        like : {post_id: postId}
	    }
    	})
    	.done(function( likers )
	        {
	        	var element = document.getElementById("likers-data");
				var para = document.createElement("p");
				var node = document.createTextNode("People liked this post..");
				para.appendChild(node);
				element.appendChild(para);

	        	for (var i = 0, length = likers.length; i < length; i++) {
					para = document.createElement("p");
					node = document.createTextNode(likers[i].username);
					para.appendChild(node);
					element.appendChild(para);
				}			
				
 				modal.style.display = "block";

			})
        .fail(function( msg )
	     	{
	        	alert("some thing go wrong ")
			});

})


// When the user clicks on <span> (x), close the modal
$('.close-popup').click(function(){
   	$('#likers-data').empty();
   	modal.style.display = "none";

})
// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        // document.getElementById("likers-data").empty();
	   	$('#likers-data').empty();
        modal.style.display = "none";
    }
} 





$('.edit-btn').click(function() {
	var commentId = $(this).data('comment-id')
	var input = $('#comment-input-' + commentId)
	var commentBody = $('#comment-body-' + commentId)
	
	input.val(commentBody.text())
	$(this).hide()
	input.show()
	commentBody.hide()
})

$('.comment-edit').keyup(function(event) {
	var commentEdit = $(this)
	var commentId = commentEdit.data('comment-id')
	var commentBody = $('#comment-body-' + commentId)
	var editButton = $('#edit-btn-' + commentId)

	
	if(event.keyCode === 13) {
		
		$.ajax({
		    type: "PUT",
		    url: '/comments/'+commentId,
		    data:
		    {
		        comment : {body: commentEdit.val() }
		    }  	
		}).done(function() {
		    // alert("Success.");
			editButton.show()
			commentBody.text(commentEdit.val())
			commentEdit.hide()
			commentBody.show()

		}).fail(function() {
		    alert("some thing go wrong");
				commentEdit.hide()
			commentBody.show()

		});

	}else if (event.keyCode === 27){
		editButton.show()
		commentEdit.hide()
		commentBody.show()
	}
});

$('.like-btn').click(function() {
	// alert("Hello world!")
	var postId = $(this).data('post-id')
	var Btn = $(this)
	var status = Btn.data('status')

	if(status === "like"){

		$.ajax({
	    type: "POST",
	    url: '/likes',
	    data:
	    {
	        like : {post_id: postId}
	    }
    	})
    	.done(function( msg )
	        {
	        	if (msg === "duplicate"){
	        		alert ("Like already there")
	        	}
	        	
		    	var unlikeBtn = $('#unlike-btn-' + postId)
				Btn.hide()
				unlikeBtn.show()
				location.reload();

			})
        .fail(function( msg )
	     	{
	        	alert("some thing go wrong ")
			});

	}else{

		$.ajax({
	    type: "DELETE",
	    url: '/likes',
	    data:
	    {
	        like : {post_id: postId}
	    }
    	})
    	.done(function( msg )
	        {
		    	var likeBtn = $('#like-btn-' + postId)
		    	Btn.hide()
		    	likeBtn.show()
				location.reload();

			})
        .fail(function( msg )
	     	{
	        	alert("some thing go wrong ")
			}); 

	}	
})


