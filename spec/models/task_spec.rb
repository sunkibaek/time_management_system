require 'rails_helper'

describe Task do
  describe '.order_by_date_desc' do
    it 'returns tasks ordered by Date descendingly' do
      task_of_older = create :task, date: '01/01/2015'
      task_of_newer = create :task, date: '02/01/2015'

      expect(Task.order_by_date_desc).to eq [task_of_newer, task_of_older]
    end
  end

  describe '#total_hour' do
    it 'sums up total hour for the date by the user' do
      user = create :user

      create :task, date: '03/03/2015', hour: 5, user: user
      task = create :task, date: '03/03/2015', hour: 5, user: user

      expect(task.total_hour).to eq 10
    end
  end
end
