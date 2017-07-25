class UsersController < ApplicationController
 	
 	before_action :set_user , only: [:show , :create_pdf]	
 	before_action :require_login

	def show
		# CHANGE
	
		if current_user.id != @user.id

			@is_follower = UserFollower.find_by(followee_id: @user.id, follower_id: current_user.id)? true : false
			@is_requester = FollowRequest.find_by(request_follower_id: current_user.id, request_followee_id: @user.id)? true : false
			puts "---------------------------------------------#{@is_requester}"
			if @is_follower
				@posts = Post.where("user_id = (?) ", @user.id).order(created_at: :desc)
			else
				@posts = Post.where("user_id = (?) AND privacy = (?)", @user.id , Post.privacies["public_post"]) 
							 .order(created_at: :desc)
			end 
		
		else
			@posts = Post.where("user_id = (?) ",@user.id).order(created_at: :desc)
			
		end	
	
	end	
	
	def create_pdf		 
		
		@posts = Post.where("user_id = (?) ",@user.id).order(created_at: :desc)
	
		html = render_to_string(:action => "show.html.erb" , :layout => false)
		kit = PDFKit.new(html)
		kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/custom.css.scss"
		kit.to_file("public/pdfs/hello.pdf")
		# send_data(kit.to_pdf, :filename => 'report.pdf', :type =>
		render :nothing => true	
	end



	private
	 # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

	 # # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id)
    end


	def require_login
      unless user_signed_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_user_session_path
      end
 	end

end
