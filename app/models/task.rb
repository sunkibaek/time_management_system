class Task < ActiveRecord::Base
  belongs_to :user

  def self.order_by_date_desc
    order(date: :desc)
  end

  def date=(date_in_text)
    super Date.strptime(date_in_text, '%m/%d/%Y')
  end

  def total_hour
    self.class.where(user_id: user_id, date: date).sum(:hour)
  end
end
