class TagsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    photo = Photo.find(params[:photo_id])
    sel_user = User.find(params[:sel])
    xloc = params[:xloc]
    yloc = params[:yloc]
    width = params[:width]
    height = params[:height]
    if xloc.empty? || yloc.empty? || width.empty? || height.empty?
      flash[:error] = "no tag found"
    else
      photo.tag.create(photo_id: photo.id, xloc: xloc.to_i, yloc: yloc.to_i, width: width.to_i, height: height.to_i, user_name: sel_user.first_name + " " + sel_user.last_name)
    end
    redirect_to user_photos_path(user)

  end

end