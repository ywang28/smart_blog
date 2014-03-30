class UsersController < ApplicationController
  
  def login
  end

  def index
    @users = User.all
  end

  def post_login
    @usr = User.find_by_login(params[:login_form][:login_name])
    if (@usr == nil)
      flash.now[:error] = 'Invalid user!'
      render 'login'
    elsif @usr.password_valid?(params[:login_form][:password])
      session[:user_id] = @usr.id
      redirect_to user_photos_path(@usr.id)
    else
      flash.now[:error] = 'Invalid password'
      render 'login'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  def create
    @user = User.new(user_params)
    if !@user.valid?
      render 'new'
      return
    end
    if params[:user][:password].empty?
      flash.now[:error] = 'password cannot be empty'
      render 'new'
    elsif params[:user][:password] != params[:user][:password_confirmation]
      flash.now[:error] = "password and confirmation don't match"
      render 'new'
    else
      @user.password = params[:user][:password]
      if @user.save
        redirect_to login_users_path
      else
        render 'new'
      end
    end

  end

  def new
    @user = User.new
  end

  def search
    txt = params[:query]
    photos = Photo.all
    @match = []
    if !txt.empty?
      txt = txt.downcase
      for photo in photos
        for comment in photo.comment
          if comment.comment.downcase.include? txt
            @match.push(photo)
            break
          end
        end
        if not @match.include? photo
          for tag in photo.tag
            if tag.user_name.downcase.include? txt
              @match.push(photo)
              break
            end
          end
        end
      end
    end
    render partial: 'search'
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :login)
    end

end
