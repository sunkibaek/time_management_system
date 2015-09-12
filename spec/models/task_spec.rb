require 'rails_helper'

describe Task do
  describe '.order_by_date_desc' do
    it 'returns tasks ordered by Date descendingly' do
      task_of_older = create :task, date: '01/01/2015'
      task_of_newer = create :task, date: '02/01/2015'

      expect(Task.order_by_date_desc).to eq [task_of_newer, task_of_older]
    end
  end
end
