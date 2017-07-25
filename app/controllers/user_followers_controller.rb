class UserFollowersController < ApplicationController

 	before_action :require_login

 	def index
 		@friends = current_user.followees
 	end

	def create
		# puts "========================================== #{follow_params}"

		follow_request = FollowRequest.find(follow_params[:request_id])
		puts "#{follow_request}"
		if follow_request.request_followee_id == current_user.id 
		
			follow = UserFollower.new(follower_id: follow_request.request_follower_id, followee_id: follow_request.request_followee_id)
		
			unless follow.save && follow_request.destroy
				puts "=========================#{follow.errors.full_messages}"
			end
		else
			flash[:error] = "what the hell are you doing"
		end
		
		render :nothing => true	
					
	end

	def destroy
		puts "========================================== #{follow_params}"
	
		follow_to_destroy = UserFollower.find_by(followee_id: follow_params[:followee_id] , follower_id: current_user.id)
	
		unless follow_to_destroy.destroy
			puts "=========================#{follow_to_destroy.errors.full_messages}"				 	
		end       
		render :nothing => true	


	end

	private

	 # Never trust parameters from the scary internet, only allow the white list through.
    def follow_params
      params.require(:userFollower).permit(:followee_id, :follower_id, :request_id )
       
    end

	def require_login
      unless user_signed_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_user_session_path
      end
 	end

end
