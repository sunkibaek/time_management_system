require 'securerandom'

class User < ActiveRecord::Base
  before_create :set_auth_token

  has_many :tasks

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: { minimum: 8 }

  def self.order_by_id_desc
    order(id: :desc)
  end

  def user_manager?
    roles.include? 'user_manager'
  end

  def admin?
    roles.include? 'admin'
  end

  def roles_in_text
    roles.to_sentence
  end

  def promote_to_admin
    self.roles += ['user_manager', 'admin']
    self.save
  end

  def promote_to_user_manager
    self.roles += ['user_manager']
    self.save
  end

  private

  def set_auth_token
    return if auth_token.present?

    self.auth_token = new_auth_token
  end

  def new_auth_token
    SecureRandom.uuid.gsub(/\-/,'')
  end
end
