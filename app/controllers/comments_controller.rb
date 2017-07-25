class CommentsController < ApplicationController
	
	before_action :set_comment, only: [ :edit, :update, :destroy]
	before_action :require_login
  	before_action :require_comment_owner, only: [:edit, :update, :destroy]


	def new
		
	end

	def create
	  
	  @comment = Comment.new(comment_params)
      @comment.user = current_user
      
      if @comment.save
         redirect_to @comment.post , notice:'comment was successfully created.'
      else
      	 redirect_to @comment.post , notice:'comment was successfully created.'
      end
	end

	def edit
	end
	
	def update
	  puts "-----------------------#{comment_params}"
	  if @comment.update(comment_params)
		# redirect_to @comment.post ,  notice: 'comment was successfully updated.'
		render :nothing => true	
      else
        redirect_to @comment.post ,  notice: "error comment was not  successfully updated."
      end
      
	end


	def destroy
	  post = @comment.post
	  if @comment.destroy
 	    redirect_to post, notice: 'comment was successfully destroyed.'
	  end
	
	end

	


	private

	def set_comment
      @comment = Comment.find(params[:id])
    end

	def comment_params
      params.require(:comment).permit(:body, :post_id)
    end

	def require_login
      puts "require_login"
      unless user_signed_in?
      	puts "require_login faild"
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_user_session_path
      end
    end

    def require_comment_owner
    	puts "require_comment_owner"
      if current_user != @comment.user
      	puts "require_comment_owner faild"
        flash[:danger] = 'you can only do that for your own posts !'
        redirect_to root_path
      end
    end

end
