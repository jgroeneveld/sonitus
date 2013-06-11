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

  protected

  def current_users_collection?
    @user == current_user
  end
end
