class HomepageController < ApplicationController
  
  def index
    if logged_in?
      @artworks = current_user.feed_microposts.order('created_at DESC').page(params[:page])
    elsif company_logged_in? 
      #something else.
    end
  end
end
