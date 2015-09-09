require 'rails_helper'

RSpec.feature "UserCreatesAndLogsIn", type: :feature do
  scenario 'creates an account' do
    visit '/'

    expect(page).to have_no_css 'h2', text: 'Sign Up'

    click_on 'Sign Up'

    expect(page).to have_css 'h2', text: 'Sign Up'

    fill_in 'Name', with: 'Test User'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'TestPassword'
    fill_in 'Password Confirm', with: 'TestPassword'

    click_on 'Save'

    expect(page).to have_text('User account successfully created.')
    expect(page).to have_text('Test User')
  end
end
