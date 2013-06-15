require 'acceptance/acceptance_helper'

feature 'Adding Images' do
  background do
    user_is_logged_in
  end

  scenario 'Adding an album with an image shows the image on the albums page' do
    visit new_user_album_path(current_user)

    fill_in sft(:album, :title), with: 'Mutter'
    fill_in sft(:album, :artist), with: 'Rammstein'
    fill_in sft(:album, :year), with: '2001'
    attach_file sft(:album, :image), Rails.root.join('spec', 'fixtures', 'album_image.gif')
    click_button I18n.t(:new_album)

    page.should have_image 'album_image.gif'
  end

end
