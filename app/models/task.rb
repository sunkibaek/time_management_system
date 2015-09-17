class Task < ActiveRecord::Base
  belongs_to :user

  delegate :name, :preferred_working_hour, to: :user, prefix: true

  def self.order_by_date_desc
    order(date: :desc)
  end

  def self.with_users
    includes(:user)
  end

  def date=(date_in_text)
    super Date.strptime(date_in_text, '%m/%d/%Y')
  end

  def total_hour
    self.class.where(user_id: user_id, date: date).sum(:hour)
  end
end
