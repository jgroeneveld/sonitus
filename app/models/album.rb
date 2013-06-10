class Album < ActiveRecord::Base
  belongs_to :user

  def long_title
    "#{artist} - #{title} (#{year})"
  end
end
