require 'acceptance/acceptance_helper'

feature 'Require Login' do

  scenario 'Logged In' do
    user_is_logged_in
    visit '/'
    expect(page).to have_content "Moin #{current_user.username}"
  end

  scenario 'Not logged in' do
    visit '/'
    expect(current_path).to eq '/users/sign_in'
  end

end
