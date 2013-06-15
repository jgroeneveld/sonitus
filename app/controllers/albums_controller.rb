class AlbumsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_to_current_user, except: :index

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
  end

  def create
    @album = Album.new album_params.merge(user: @user)

    if @album.save
      redirect_to user_albums_path(@user), :notice => 'Album was successfully created.'
    else
      render :action => "new"
    end
  end

  def edit
    @album = @user.albums.find params[:id]
  end

  def update
    @album = @user.albums.find params[:id]

    if @album.update(album_params)
      redirect_to user_albums_path(@user), :notice => t(:album_update_success)
    else
      render :action => "edit"
    end
  end

  def destroy
    @album = @user.albums.find params[:id]

    @album.destroy
    render text: "OK"
  end

  def search
    if params[:term].nil? || params[:term].empty?
      flash[:error] = t(:please_enter_a_search_term)
      redirect_to user_albums_path(@user)
    else
      term = params.require(:term)
      @albums = AlbumSearch.new(@user).search(term)
    end
  end

  protected

  def current_users_collection?
    @user == current_user
  end

  def album_params
    params.require(:album).permit(:title, :year, :artist)
  end

  def set_user_to_current_user
    @user = current_user
  end
end
