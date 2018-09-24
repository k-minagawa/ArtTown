class CommentsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    artwork = Artwork.find(params[:artwork_id])
    current_user.comments.find_or_create_by(artwork_id: artwork.id, comment: params[:comment])
    flash[:success] = "comment sended."
    redirect_to artwork
  end

  def destroy
    artwork = Artwork.find(params[:artwork_id])
    comment = current_user.comments.find_by(artwork_id: artwork.id)
    comment.destroy if comment
    flash[:success] = "your comment deleted."
    redirect_to artwork
  end

end
