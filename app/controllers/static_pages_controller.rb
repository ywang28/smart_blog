class StaticPagesController < ApplicationController
  def home
    if session[:user_id]
      redirect_to user_photos_path(User.find_by_id(session[:user_id]))
    end
  end

  def about
  end

  def contact
  end
end
