class AlbumsController < ApplicationController
  before_filter :authenticate_user!

  helper_method :current_users_collection?

  def index
    if params[:user_id]
      @user = User.find params[:user_id]
    else
      @user = current_user
    end

    @albums = @user.albums
  end

  def new
    @album = Album.new
    @user = current_user
  end

  def create
    @user = current_user
    @album = Album.new album_params.merge(user: @user)

    if @album.save
      redirect_to user_albums_path(@user), :notice => 'Album was successfully created.'
    else
      render :action => "new"
    end
  end

  def destroy
    @user = current_user
    @album = @user.albums.find params[:id]

    @album.destroy
    render text: "OK"
  end

  protected

  def current_users_collection?
    @user == current_user
  end

  def album_params
    params.require(:album).permit(:title, :year, :artist)
  end
end
