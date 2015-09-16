require 'rails_helper'

describe User do
  describe '#user_manager?' do
    it 'determines if user is user manager or not' do
      regular_user = create :user
      user_manager = create :user_manager

      expect(regular_user.user_manager?).to eq false
      expect(user_manager.user_manager?).to eq true
    end
  end
end
