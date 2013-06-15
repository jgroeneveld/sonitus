class Album < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, AlbumImageUploader

  validates :artist, presence: true
  validates :title, presence: true
  validates :year, presence: true

  default_scope { order('LOWER(artist) ASC') }
end
