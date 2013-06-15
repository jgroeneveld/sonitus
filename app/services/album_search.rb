class AlbumSearch
  def initialize(user)
    @user = user
  end

  def search(term)
    term = "%#{term}%"
    @user.albums.where 'title like ? OR artist like ?', term, term
  end
end