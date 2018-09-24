class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  def require_company_logged_in
    unless company_logged_in?
      redirect_to root_url #後で変更 company_login_url
    end
  end
  
  def require_anonymous
    if (logged_in?) or (company_logged_in?)
      flash[:danger] = "you need to logout."
      redirect_to root_url
    end
  end
  
  def artworks_counts(user)
    user.artworks.count
  end
  
  def followings_counts(user)
    user.followings.count
  end
  
  def followers_counts(user)
    user.followers.count
  end
  
  def likings_counts(user)
    user.liking_artworks.count
  end
end
