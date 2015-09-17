require 'rails_helper'

feature 'User manager manages users' do
  let!(:regular_user) { create :user, name: 'Regular User' }
  let!(:user_manager) { create :user, roles: ['regular', 'user_manager'] }

  before do
    sign_in user_manager
  end

  scenario 'can see users menu', js: true do
    visit '/'

    expect(page).to have_css('a', text: 'Users', visible: true)

    sign_out

    sign_in regular_user

    expect(page).to have_css('a', text: 'Users', visible: false)
  end

  scenario 'can visit user manage page', js: true do
    visit '/admin/users'

    expect(page).to have_css('h1', text: 'User management')

    sign_out

    sign_in regular_user

    visit '/admin/users'

    expect(page).not_to have_css('h1', text: 'User management')
  end

  scenario 'changes settings of other users', js: true do
    visit '/admin/users'

    within 'table tbody tr:last-of-type' do
      expect(page).to have_css('td', text: 'Regular User')

      fill_in 'preferred_working_hour', with: 4

      click_on 'Save'
    end

    expect(page).to have_text('User account successfully updated.')
  end
end
