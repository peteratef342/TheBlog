class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  before_action :require_post_owner, only: [:edit, :update, :destroy]
  # GET /posts
  # GET /posts.json
  def index

    @posts = Post.where("user_id in (?) OR user_id = (?) OR privacy = (?)", 
                        current_user.followee_ids, current_user.id , Post.privacies["public_post"])
                        .order(created_at: :desc)

    @my_friends = current_user.followees.ids
    
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments
    @comment = Comment.new
    @comment.post_id = @post.id
    @already_liked = Like.find_by(post_id: @post.id, user_id: current_user.id)? true : false
    @is_shared = @post.parent_post_id? 

    if @is_shared
      @perant_post = Post.find(@post.parent_post_id)
    end

  end

  def share
    @parent_post = Post.find(params[:id])
    @my_friends = current_user.followees
    @post = Post.new
  end

  # GET /posts/new
  def new
    @post = Post.new    
    @my_friends = current_user.followees

  end

  # GET /posts/1/edit
  def edit
    
     @is_edit = true

  end

  # POST /posts
  # POST /posts.json
  def create
    
    @my_friends = current_user.followees
    
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new 
    end

  end

  # PATCH/PUT /posts/1
  def update

      old_ids = @post.tags.map(&:user_id)
      new_ids = post_params[:user_ids]
      new_ids.shift

      @post.user_ids = new_ids


      if @post.update(post_params)
        redirect_to @post ,  notice: 'Post was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /posts/1
  def destroy
    
    if @post.destroy
      redirect_to posts_url, notice: 'Post was successfully destroyed.' 
    end

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      @my_friends = current_user.followees

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body , :privacy, :parent_post_id, user_ids: [])

    end

    def require_login
      unless user_signed_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_user_session_path
      end
    end

    def require_post_owner
      if current_user != @post.user
        flash[:danger] = 'you can only do that for your own posts !'
        redirect_to root_path
      end
    end

end
