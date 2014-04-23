class CommentsController < ApplicationController
	before_action :require_user, only: [:create]

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.new(params.require(:comment).permit(:body))
		@comment.user = @current_user

		if @comment.save
			flash[:notice] = 'Your comment has been created'
			redirect_to post_path(@post)
		else
			render 'posts/show'
		end
	end

	def vote
		@post = Post.find(params[:id])
		@comment = Comment.find(params[:id])
		@vote = Vote.create(voteable: @comment, user:current_user, vote: params[:vote])

		redirect_to :back
	end
end
