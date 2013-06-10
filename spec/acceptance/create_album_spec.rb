require 'acceptance/acceptance_helper'

feature 'Create album' do
  background do
    user_is_logged_in
  end

  scenario 'Empty Startpage' do
    visit '/'
    expect(page).to have_link 'Add one now', href: '/albums/new'
  end

end
