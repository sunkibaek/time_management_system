class Task < ActiveRecord::Base
  belongs_to :user

  def self.order_by_date_desc
    order(date: :desc)
  end

  # def date=(date_with_time_zone)
  #   # 2014-01-31T15:00:00.000Z
  #   converted_date = Date.strptime(date_with_time_zone, '%d-%m-%Y')
  #
  #   super(converted_date)
  # end

  def total_hour
    self.class.where(user_id: user_id, date: date).sum(:hour)
  end
end
