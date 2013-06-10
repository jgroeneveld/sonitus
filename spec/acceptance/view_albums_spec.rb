require 'acceptance/acceptance_helper'

feature 'View albums' do
  background do
    @user = Fabricate(:user)
    login_as @user, scope: :user
  end

  scenario 'No albums saved' do
    visit '/'
    page.should have_content 'No Albums added yet'
  end

end
