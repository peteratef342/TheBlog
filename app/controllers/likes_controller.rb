class LikesController < ApplicationController

 	before_action :require_login

	def new
	end

	def create

	  if Like.find_by(user_id: current_user.id, post_id: like_params[:post_id])
	  	
	  	render :text => "duplicate"	
		return
	  end	

	  like = Like.new(like_params)      
	  like.user_id = current_user.id
      if like.save
      	post = Post.find(like.post_id)
      	post.likes_num = post.likes_num + 1
      	
      	if post.save
      		# flash[:success] = "like is saved"
      	else
      		# flash[:danger] = "like not saved"
      		puts "#{post.errors.full_messages }"
      	end
      else
      	 puts "============nooo like"
      	 puts "#{like.errors.full_messages }"
      end

	  render :nothing => true	
	end

	def destroy
		puts "#{like_params}"
		
		like_to_delete = Like.find_by(post_id: like_params[:post_id], user_id: current_user.id)      
		post = Post.find(like_params[:post_id])
		
		if like_to_delete.destroy
			
			post = Post.find(like_params[:post_id])
	      	post.likes_num = post.likes_num - 1
	      	
	      	if post.save
	      		# flash[:success] = "like is destroied"
	      	else
	      		# flash[:danger] = "like not destroied"
	      		puts "#{post.errors.full_messages }"
	      	end

		else 
			puts "destrooooooooy faild"
			redirect_to post 
		end

		render :nothing => true	
				
	end

	def get_likers
	    likers = Post.find(like_params[:post_id]).likers
	    render json: likers
  	end

	private

	def like_params
      params.require(:like).permit(:user_id, :post_id )
    end

     def require_login
      unless user_signed_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_user_session_path
      end
    end


end
