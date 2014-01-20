class CommentsController < ApplicationController
  before_action  :signed_in_user, only: [:new, :create, :update]

  def new
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:photo_id])
    @comment = @photo.comment.build
  end
  def create
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:photo_id])
    @comment = Comment.new(date_time: Time.now.strftime("%Y-%m-%d %H:%M:%S"), comment: params[:comment][:comment], photo_id: params[:photo_id], user_id: session[:user_id])
    if @comment.valid?
      @comment.save
      redirect_to user_photos_path(@user)
    else
      render 'new'
    end
  end
  def update
    @user = User.find(params[:user_id])
    redirect_to user_photos_path(@user)
  end

end