require 'rails_helper'

RSpec.feature "UserCreatesAndLogsIn", type: :feature do
  scenario 'creates an account' do
    visit '/'

    click 'Sign Up'

    fill_in 'Name', 'Test User'
    fill_in 'Email', 'test@example.com'
    fill_in 'Password', 'TestPassword'
    fill_in 'Password Confirm', 'TestPassword'

    click 'Save'

    page.should have_content('User account successfully created.')
    page.should have_content('Test User')
  end
end
