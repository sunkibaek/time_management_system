class Task < ActiveRecord::Base
  belongs_to :user

  def self.order_by_date_desc
    order(date: :desc)
  end
end
