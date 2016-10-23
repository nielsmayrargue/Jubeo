class CommentsController < ApplicationController

	def create
		track = Track.find(params[:id])
		user = current_user
		body = comment_params[:body]
		comment = Comment.build_from( track, user.id, body )
		comment.save
		redirect_to tracks_path
	end


  private
  def comment_params
    params.require(:comment).permit(:body)
  end

end
