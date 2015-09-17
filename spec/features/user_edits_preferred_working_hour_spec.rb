require 'rails_helper'

feature 'User edits preferred working hour' do
  let!(:user) { create :user }

  before do
    sign_in user
  end

  scenario 'sees PWH in nav bar and navigates to settings', js: true do
    visit '/tasks'

    within 'nav' do
      page.find('.preferred-working-hour a b',
        text: user.preferred_working_hour).click
    end

    expect(page).to have_field('Preferred Working Hour',
      with: user.preferred_working_hour)
  end

  scenario 'updates PWH in settings', js: true do
    visit '/settings'

    expect(page).to have_text 'Preferred working hour: 8'

    fill_in 'Preferred Working Hour', with: '4'

    click_on 'Submit'

    expect(page).to have_text 'Preferred working hour: 4'
  end
end
