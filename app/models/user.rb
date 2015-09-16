class User < ActiveRecord::Base
  has_many :tasks

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  def user_manager?
    roles.include? 'user_manager'
  end
end
