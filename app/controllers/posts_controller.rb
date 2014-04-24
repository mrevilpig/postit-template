class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :set_user, only: [:edit, :update]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update]

  def index
  	@posts = Post.all.sort_by{|x| x.total_votes}.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
  	@post.user = @current_user

  	if @post.save
  		flash[:notice] = "Post created!!"
  		redirect_to posts_path
		else
			render :new
		end

  end

  def edit
  end

  def update
  	if @post.update(post_params)
  		flash[:notice] = "Update Success"
  		redirect_to post_path(@post)
  	else
  		render :edit
  	end
  end

  def vote
    vote = Vote.new(voteable: @post, user: current_user, vote: params[:vote])

    if vote.save
      flash[:notice] = "Your vote was counted."
    else
      flash[:error] = "You have already voted on \"#{@post.title}\""
    end

    redirect_to :back
  end

  private

  def post_params
  	params.require(:post).permit!
  end

  def set_post
  	@post = Post.find(params[:id])
  end

  def set_user
    @user = @post.user
  end
end
