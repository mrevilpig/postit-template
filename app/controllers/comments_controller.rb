class CommentsController < ApplicationController
	before_action :require_user, only: [:create]

	def create
		@post = Post.find_by slug: params[:post_id]
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
		@comment = Comment.find(params[:id])
		@vote = Vote.new(voteable: @comment, user:current_user, vote: params[:vote])

    respond_to do |format|
      if @vote.save
        format.html{redirect_to :back, notice: 'Your vote is counted'}
        format.js{}
      else
        format.html{redirect_to :back, notice: 'You can only vote once'}
        format.js{}
      end
    end
  end
end
