class LikesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    artwork = Artwork.find(params[:artwork_id])
    current_user.like(artwork)
    flash[:success] = "added to Liked Artworks."
    redirect_back(fallback_location: root_path)
  end

  def destroy
    artwork = Artwork.find(params[:artwork_id])
    current_user.unlike(artwork)
    flash[:success] = "removed from Liked Artworks."
    redirect_back(fallback_location: root_path)
  end
end
