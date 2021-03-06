require 'spec_helper'

describe AlbumsController do
  before(:each) do
    @current_user = Fabricate :user_with_albums
    sign_in @current_user
  end

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

    it 'rerenders the page if the record is not valid' do
      get :create, album: { title: '' }, user_id: current_user.id
      response.response_code.should == 200
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

    it 'rerenders the page if the record is not valid' do
      post :update, id: album.id, album: { title: '' }, user_id: current_user.id
      response.response_code.should == 200
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

  describe '#search' do
    let(:album_search) { mock('album_search') }

    it 'calls AlbumSearch and assigns the result' do
      search_term = 'Something'
      search_result = [1, 2, 3]
      AlbumSearch.should_receive(:new).with(current_user).and_return(album_search)
      album_search.should_receive(:search).with(search_term).and_return(search_result)

      get :search, term: search_term, user_id: current_user.id

      assigns(:albums).should == search_result
    end

    it 'flashes an error if no term entered' do
      get :search, term: '', user_id: current_user.id
      response.should redirect_to user_albums_path(current_user)
      flash[:error].should == I18n.t(:please_enter_a_search_term)
    end
  end

  describe '#show' do
    it 'assigns the album' do
      album = Fabricate(:album, user: current_user)
      get :show, id: album.id, user_id: current_user.id
      assigns(:album).should == album
    end
  end
end
