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
		comment = Comment.find(params[:id])
		vote = Vote.new(voteable: comment, user:current_user, vote: params[:vote])

    if vote.save
      flash[:notice] = "Your vote was counted."
    else
      flash[:error] = "Your vote was not counted"
    end

		redirect_to :back
	end
end
