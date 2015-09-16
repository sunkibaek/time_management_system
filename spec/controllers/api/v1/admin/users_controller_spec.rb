require 'rails_helper'

describe Api::V1::Admin::UsersController do
  let!(:regular_user) { create :user }
  let!(:user_manager) { create :user_manager }

  describe '#index' do
    context 'logged in as a regular user' do
      it 'returns 403 error' do
        sign_in regular_user

        get :index, format: :json

        expect(response.status).to eq 403
      end
    end

    context 'logged in as a user manager' do
      it 'returns users collection' do
        sign_in user_manager

        get :index, format: :json

        expect(response.status).to eq 200
        expect(response).to render_template('api/v1/admin/users/index')
      end
    end
  end
end
