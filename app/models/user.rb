class User < ActiveRecord::Base
  has_many :tasks

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: { minimum: 8 }

  def user_manager?
    roles.include? 'user_manager'
  end
end
