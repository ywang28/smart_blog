module UsersHelper
  def signed_in_user
    redirect_to login_users_path unless session[:user_id]
  end
end
