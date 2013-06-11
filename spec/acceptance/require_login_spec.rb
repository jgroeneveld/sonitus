require 'acceptance/acceptance_helper'

feature 'Require Login' do

  scenario 'Logged In' do
    user_is_logged_in
    visit '/'
    page.should have_content "Moin #{current_user.username}"
  end

  scenario 'Not logged in' do
    visit '/'
    current_path.should eq '/users/sign_in'
  end

end
