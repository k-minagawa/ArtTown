class UsersController < ApplicationController
  before_action :require_user_logged_in, except: [:index, :show, :new, :create]
  before_action :require_anonymous, only: [:new, :create]
  
  def index
    @users = User.all.page(params[:page])
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Your Accont has been Successfully Uploaded."
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:danger] = "Upload Failed."
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your Accont has been Successfully Updated."
      redirect_to @user
    else
      flash[:danger] = "Update Failed."
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "Your Account has been deleted."
    session[:user_id] = nil
    redirect_to root_url
  end
  
  def likes
    @user = User.find(params[:id])
    @liking_artworks = @user.liking_artworks.page(params[:page])
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
  end 
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :birthday, :image_path, :about)
  end
end
