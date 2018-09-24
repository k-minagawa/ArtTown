class ArtworksController < ApplicationController
    before_action :require_user_logged_in, except[:index, :show]
    
  def index
    @artworks = Artwork.all.page(params[:page])
  end
  
  def show
    @artwork = Artwork.find(params[:id])
  end
  
  def new
    @artwork = current_user.artworks.build
  end
  
  def create
    @artwork = current_user.artworks.build(artwork_params)
    if @artwork.save
      flash[:success] = "Your Artwork has been Successfully Uploaded."
      redirect_to @artwork
    else
      flash[:danger] = "Upload Failed."
      render :new
    end
  end
  
  def edit
    @artwork = current_user.artworks.find_by(id: params[:id])
  end
  
  def update
    @artwork = current_user.artworks.find_by(id: params[:id])
    if @artwork.update(artwork_params)
      flash[:success] = "Your Artwork has been Successfully Updated."
      redirect_to @artwork
    else
      flash[:danger] = "Update Failed."
      render :edit
    end
  end
  
  def destroy
    artwork = current_user.artworks.find_by(id: params[:id])
    if artwork #correct_user?
      artwork.destroy
      flash[:success] = "Your Artwork has been deleted."
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Failed to delete a artwork."
      redirect_to root_url
    end
  end
  
  private
  
  def artwork_params
    params.require(:artwork).permit(:title, :image_path, :is_mature)
  end

end
