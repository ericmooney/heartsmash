class PhotosController < ApplicationController
  def new
  end

  def create
    @photo = Photo.new(params[:photo])
    if @photo.save
      flash[:notice] = "Successfully created photo."
      redirect_to user_path(current_user.id)
    else
      render :action => 'new'
    end
  end


  def show
    @photo = Photo.find(params[:id])

  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:notice] = "Successfully destroyed photo."
    redirect_to user_path(current_user.id)
  end
end

