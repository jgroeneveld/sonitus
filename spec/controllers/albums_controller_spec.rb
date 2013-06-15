require 'spec_helper'

describe AlbumsController do
  before(:each) {
    @current_user = Fabricate :user_with_albums
    sign_in @current_user
  }

  let(:current_user) { @current_user }
  let(:other_user) { Fabricate :user }
  let (:album_params) { Fabricate.attributes_for :album }

  describe '#index' do
    context 'when a user is given' do
      it 'assigns the users albums' do
        user = Fabricate :user_with_albums
        get :index, user_id: user.id

        assigns(:user).should == user
        assigns(:albums).should == user.albums
      end
    end

    context 'when no user is given' do
      it 'assigns the current users albums' do
        get :index

        assigns(:user).should == current_user
        assigns(:albums).should == current_user.albums
      end
    end
  end

  describe '#new' do
    it 'assigns a new album' do
      get :new, user_id: current_user.id
      assigns(:album).attributes.should == Album.new.attributes
    end
  end

  describe '#create' do
    it 'creates the new album' do
      get :create, album: album_params, user_id: current_user.id
      Album.where(album_params).first.should_not be nil
    end

    it 'creates the new album always for the current user' do
      get :create, album: album_params.merge({user_id: other_user.id}), user_id: other_user.id
      album = Album.where(album_params).first
      album.user_id.should == current_user.id
    end

    it 'redirects to the albums of the user after success' do
      get :create, album: album_params, user_id: current_user.id
      response.should redirect_to user_albums_path(current_user)
    end
  end

  describe '#edit' do
    it 'assigns the album' do
      album = Fabricate(:album, user: current_user)
      get :edit, id: album.id, user_id: current_user.id
      assigns(:album).should == album
    end

    it 'allows only albums of the current user to be edited' do
      album = Fabricate(:album, user: other_user)

      expect {
        get :edit, id: album.id, user_id: other_user.id
      }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe '#update' do
    let (:album) { Fabricate :album, user: current_user }

    it 'updates the album' do
      post :update, id: album.id, album: album_params, user_id: current_user.id
      album.reload
      album.title.should == album_params[:title]
    end

    it 'updates the album always for the current user' do
      post :update, id: album.id, album: album_params.merge({user_id: other_user.id}), user_id: other_user.id
      album.reload
      album.user_id.should == current_user.id
    end

    it 'redirects to the albums of the user after success' do
      post :update, id: album.id, album: album_params, user_id: current_user.id
      response.should redirect_to user_albums_path(current_user)
    end
  end

  describe '#destroy' do
    it 'destroys an album' do
      album = Fabricate(:album, user: current_user)
      delete :destroy, id: album.id, user_id: current_user.id
      expect { Album.find album.id }.to raise_error ActiveRecord::RecordNotFound
    end

    it 'destroys only albums of the current user' do
      album = Fabricate(:album, user: other_user)
      expect {
        delete :destroy, id: album.id, user_id: current_user.id
      }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
