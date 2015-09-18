require 'rails_helper'

feature 'User manager manages users' do
  let!(:user_manager) { create :user, roles: ['regular', 'user_manager'] }
  let!(:regular_user) { create :user, name: 'Regular User' }

  scenario 'can see users menu', js: true do
    request_header_with user_manager.auth_token

    visit '/'

    expect(page).to have_css('a', text: 'Manage users', visible: true)

    request_header_with regular_user.auth_token

    visit '/'

    expect(page).not_to have_css('a', text: 'Manage users')
  end

  scenario 'can visit user manage page', js: true do
    request_header_with user_manager.auth_token

    visit '/admin/users'

    expect(page).to have_css('h1', text: 'User management')

    request_header_with regular_user.auth_token

    visit '/admin/users'

    expect(page).not_to have_css('h1', text: 'User management')
  end

  scenario 'changes settings of other users', js: true do
    request_header_with user_manager.auth_token

    visit '/admin/users'

    within 'table tbody tr', match: :first do
      expect(page).to have_css('td', text: 'Regular User')

      fill_in 'preferred_working_hour', with: 4

      click_on 'Save'
    end

    expect(page).to have_text('User account successfully updated.')
  end
end
