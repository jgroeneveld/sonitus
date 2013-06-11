require 'acceptance/acceptance_helper'

feature 'Authentication' do

  context 'Registering' do
    scenario 'New user registers successfully' do
      visit '/'

      click_on 'Sign Up'
      fill_in 'Username', with: 'Harald'
      fill_in 'Email', with: 'harald@example.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_button 'Sign up'

      page.should have_content 'Moin Harald'
      User.where(email: 'harald@example.com').count.should == 1
    end

    scenario 'New user tries to register without entering form' do
      visit '/'

      click_on 'Sign Up'
      click_button 'Sign up'
      page.should have_content 'Email can\'t be blank'
      page.should have_content 'Password can\'t be blank'
      page.should have_content 'Username can\'t be blank'
    end

    scenario 'New user tries to register but passwords dont match' do
      visit '/'

      click_on 'Sign Up'
      fill_in 'Username', with: 'Harald'
      fill_in 'Email', with: 'harald@example.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: 'abcdef'
      click_button 'Sign up'

      page.should have_content 'Password confirmation doesn\'t match Password'
    end

    scenario 'New user tries to register with already taken email' do
      visit '/'

      existing_user = Fabricate(:user)

      click_on 'Sign Up'
      fill_in 'Username', with: 'Harald'
      fill_in 'Email', with: existing_user.email
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_button 'Sign up'

      page.should have_content 'Email has already been taken'
    end
  end

  context 'Logging in' do
    scenario 'With existing Account' do
      visit '/'

      user = Fabricate(:user)

      click_on 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'

      page.should have_content 'Signed in successfully'
    end

    scenario 'With wrong credentials' do
      visit '/'

      click_on 'Sign In'
      fill_in 'Email', with: 'whatever@example.com'
      fill_in 'Password', with: '12345678'
      click_button 'Sign in'

      page.should have_content 'Invalid email or password'
    end
  end

end
