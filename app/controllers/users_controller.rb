class UsersController < ApplicationController

  skip_before_filter :require_login, :only => [:index, :new, :create]

  def index
    search_query = params[:query]

    if search_query.blank?
      @users = User.find(:all, :conditions => ["id != ?", current_user.id])
    else
      @users = User.where("email @@ :q", :q => "%#{search_query}%")

    end

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def show
    @photo = Photo.new

    @user = User.find(params[:id])
    @photos = @user.photos

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(:users, :notice => 'Your account was successfully created.') }
        format.js
      else
        format.html { render action: "new" }
        format.js
      end
    end
  end

  def update
    @user = User.find(session[:user_id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.js
      else
        format.html { render action: "edit" }
        format.js
      end
    end
  end

  def destroy
    @user = User.find(session[:user_id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.js
    end
  end
end
