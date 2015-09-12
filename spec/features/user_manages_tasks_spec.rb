require 'rails_helper'

feature 'User manages tasks' do
  scenario 'inputs a task', js: true do
    user = create :user
    sign_in user

    visit '/'

    fill_in 'Task', with: 'Sample task description'
    fill_in 'Date', with: '12/31/2014'
    fill_in 'Hours', with: '4'

    click_on 'Add a Task'

    expect(page).to have_text('Task successfully added.')
    expect(page).to have_css('table tr td', text: 'Sample task description')
  end

  scenario 'change task list order', js: true do
    user = create :user
    sign_in user
    task_of_older = create :task, date: '9/10/2015', user: user
    task_of_newer = create :task, date: '9/11/2015', user: user
    task_of_older_text = "#{task_of_older.description} #{task_of_older.date}" \
      " #{task_of_older.hour}"
    task_of_newer_text = "#{task_of_newer.description} #{task_of_newer.date}" \
      " #{task_of_newer.hour}"

    visit '/'

    expect(page).to have_css('table tbody tr:first-child',
                             text: task_of_newer_text)
    expect(page).to have_css('table tbody tr:last-child',
                             text: task_of_older_text)

    find('#date-toggle').click

    expect(page).to have_css('table tbody tr:first-child',
                             text: task_of_older_text)
    expect(page).to have_css('table tbody tr:last-child',
                             text: task_of_newer_text)
  end
end
