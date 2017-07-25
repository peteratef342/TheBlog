class FollowRequestsController < ApplicationController

 	before_action :require_login

 	def index
		@requests = FollowRequest.where("request_followee_id = (?)", current_user.id) 		
 	end

	def create
		
		follow_request =  FollowRequest.new(follow_request_params)
		follow_request.request_follower_id = current_user.id

		unless follow_request.save
			puts "=========================#{follow_request.errors.full_messages}"
		end

		render :nothing => true	

	end

	def destroy

		request_to_destroy = FollowRequest.find_by(request_followee_id: follow_request_params[:request_followee_id] ,
												   request_follower_id: current_user.id)
	
		unless request_to_destroy.destroy
			puts "=========================#{follow_to_destroy.errors.full_messages}"				 	
		end       
		render :nothing => true	


	end


	private

	def follow_request_params
      params.require(:FollowRequest).permit(:request_followee_id, :request_follower_id )
    end

	def require_login
      unless user_signed_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_user_session_path
      end
 	end

end
