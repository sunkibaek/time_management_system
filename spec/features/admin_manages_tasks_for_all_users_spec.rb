require 'rails_helper'

feature 'Admin manages tasks for all users' do
  scenario 'sees all tasks of users', js: true do
    user = create :user
    task_of_other_user = create :task,
      description: 'Task of other user', user: user
    admin = create :admin

    request_header_with admin.auth_token

    visit '/'

    click_on 'Manage tasks'

    expect(page).to have_text(task_of_other_user.description)
  end

  scenario 'edits tasks of other users', js: true do
    user = create :user
    task_of_other_user = create :task,
      description: 'Task of other user', user: user
    admin = create :admin

    request_header_with admin.auth_token

    visit '/admin/tasks'

    click_on task_of_other_user.description

    fill_in 'Task', with: 'Task Edited by Admin'

    click_on 'Submit'

    expect(page).to have_text('Task successfully edited.')
    expect(page).to have_css('table tr td', text: 'Task Edited by Admin')
  end

  scenario 'deletes tasks of other users', js: true do
    user = create :user
    task_of_other_user = create :task,
      description: 'Task of other user', user: user
    admin = create :admin

    request_header_with admin.auth_token

    visit "/tasks/edit/#{task_of_other_user.id}"

    click_on 'Delete'

    # accept confirmationd dialog box
    # page.driver.browser.switch_to.alert.accept

    expect(page).to have_text('Task successfully deleted.')
  end
end
