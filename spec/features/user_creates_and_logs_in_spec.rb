require 'rails_helper'

RSpec.feature "UserCreatesAndLogsIn", type: :feature do
  scenario 'creates an account' do
    visit '/'

    click_on 'Sign Up'

    fill_in 'Name', with: 'Test User'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'TestPassword'
    fill_in 'Password Confirm', with: 'TestPassword'

    click_on 'Save'

    page.should have_content('User account successfully created.')
    page.should have_content('Test User')
  end
end
