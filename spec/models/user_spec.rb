require 'rails_helper'

describe User do
  describe '.order_by_id_desc' do
    it 'returns users list in descending order of id' do
      first_user = create :user
      last_user = create :user

      expect(User.order_by_id_desc).to eq [last_user, first_user]
    end
  end

  describe '#user_manager?' do
    it 'determines if user is user manager or not' do
      regular_user = create :user
      user_manager = create :user_manager

      expect(regular_user.user_manager?).to eq false
      expect(user_manager.user_manager?).to eq true
    end
  end

  describe '#admin?' do
    it 'determines if user is admin or not' do
      regular_user = create :user
      user_manager = create :user_manager
      admin = create :admin

      expect(regular_user.admin?).to eq false
      expect(user_manager.admin?).to eq false
      expect(admin.admin?).to eq true
    end
  end
end
