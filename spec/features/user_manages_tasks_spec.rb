require 'rails_helper'

feature 'User manages tasks' do
  let!(:user) { create :user }

  before do
    sign_in user
  end

  scenario 'adds a new task', js: true do
    visit '/tasks'

    click_on 'Add a Task'

    fill_in 'Task', with: 'Sample task description'
    fill_in 'Date', with: '12/31/2014'
    fill_in 'Hours', with: '4'

    click_on 'Submit'

    expect(page).to have_text('Task successfully added.')
    expect(page).to have_css('table tr td', text: 'Sample task description')
  end

  scenario 'edits a task', js: true do
    task = create :task, description: 'Test task desc', user: user

    visit '/tasks'

    click_on task.description

    expect(page).to have_field('Task', with: 'Test task desc')

    fill_in 'Task', with: 'Edited task description'
    fill_in 'Date', with: '12/31/2014'
    fill_in 'Hours', with: '4'

    click_on 'Submit'

    expect(page).to have_text('Task successfully edited.')
    expect(page).to have_css('table tr td', text: 'Edited task description')
  end

  scenario 'deletes a task', js: true do
    task = create :task, description: 'Test task desc', user: user

    visit "/tasks/edit/#{task.id}"

    click_on 'Delete'

    expect(page).to have_text('Task successfully deleted.')
  end

  scenario 'change task list order', js: true do
    task_of_older = create :task, date: '09/10/2015', user: user
    task_of_newer = create :task, date: '09/11/2015', user: user

    visit '/tasks'

    expect(page).to have_css('table tbody tr:first-child',
                             text: task_text(task_of_newer))
    expect(page).to have_css('table tbody tr:last-child',
                             text: task_text(task_of_older))

    find('#date-toggle').click

    expect(page).to have_css('table tbody tr:first-child',
                             text: task_text(task_of_older))
    expect(page).to have_css('table tbody tr:last-child',
                             text: task_text(task_of_newer))
  end

  scenario 'see the list with overworking days highlighted', js: true do
    user.preferred_working_hour = 8

    task_of_less_working_day = create(
      :task, hour: 3, date: '09/10/2015', user: user)
    task_1_of_regular_day = create(:task,
      hour: 5, date: '09/11/2015', user: user)
    task_2_of_regular_day = create(:task,
      hour: 5, date: '09/11/2015', user: user)

    visit '/tasks'

    expect(page).to have_css('table tbody tr.danger',
      text: task_text(task_of_less_working_day))
    expect(page).to have_css('table tbody tr.success',
      text: task_text(task_1_of_regular_day))
    expect(page).to have_css('table tbody tr.success',
      text: task_text(task_2_of_regular_day))
  end

  scenario 'filters the list with from and to date', js: true do
    task_out_of_range = create :task, date: '09/01/2014', user: user
    task_in_range = create :task, date: '09/01/2015', user: user

    visit '/tasks'

    fill_in 'From', with: '01/01/2015'
    fill_in 'To', with: '12/31/2015'

    expect(page).to have_css('table tbody tr',
      text: task_text(task_in_range))
    expect(page).not_to have_css('table tbody tr',
      text: task_text(task_out_of_range))
  end

  scenario 'exports the filtered list', js: true do
    task_out_of_range = create :task, date: '09/01/2014', user: user
    task_in_range = create :task, date: '09/01/2015', user: user
    another_task_in_range = create :task, date: '09/02/2015', user: user
    total_hour = task_in_range.hour + another_task_in_range.hour

    visit '/tasks'

    fill_in 'From', with: '01/01/2015'
    fill_in 'To', with: '12/31/2015'

    click_on 'Export'

    expect(page).to have_text('01/01/2015')
    expect(page).to have_text('12/31/2015')
    expect(page).to have_text("#{total_hour}h")
    expect(page).to have_text(task_in_range.description)
    expect(page).to have_text(another_task_in_range.description)
  end

  def task_text(task)
    "#{task.description} #{task.date.strftime('%m/%d/%Y')} #{task.hour}"
  end
end
