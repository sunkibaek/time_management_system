require 'rails_helper'

feature 'Admin manages tasks for all users' do
  scenario 'sees all tasks of users', js: true do
    user = create :user
    task_of_other_user = create :task,
      description: 'Task of other user', user: user
    admin = create :admin

    sign_in admin

    visit '/'

    click_on 'Tasks manage'

    expect(page).to have_text(task_of_other_user.description)
  end
end
