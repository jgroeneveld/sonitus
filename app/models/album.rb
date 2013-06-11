class Album < ActiveRecord::Base
  belongs_to :user

  validates :artist, presence: true
  validates :title, presence: true
  validates :year, presence: true

  def long_title
    "#{artist} - #{title} (#{year})"
  end
end
