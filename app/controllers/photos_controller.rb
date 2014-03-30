class PhotosController < ApplicationController
  before_action  :signed_in_user, only: [:new, :create]

  def index
    @user = User.find(params[:user_id])
  end
  def new
    @user = User.find(params[:user_id])
    @photo = @user.photo.build
  end
  def create
    @user = User.find(params[:user_id])
    if !params[:photo]
      flash[:error] = "No file selected!"
      redirect_to new_user_photo_path(@user)
      return
    end
    uploaded = params[:photo][:picture]
    File.open(Rails.root.join('public', 'images', uploaded.original_filename), 'wb') do |file|
      file.write(uploaded.read)
    end
    @user.photo.create(date_time: Time.now, file_name: uploaded.original_filename)
    redirect_to user_photos_path(@user)
  end

end