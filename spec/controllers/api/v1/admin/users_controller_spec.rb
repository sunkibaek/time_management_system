require 'rails_helper'

describe Api::V1::Admin::UsersController do
  let!(:regular_user) { create :user }
  let!(:user_manager) { create :user_manager }

  describe '#index' do
    context 'logged in as a regular user' do
      it 'returns 403 error' do
        authorize_with regular_user.auth_token

        get :index, format: :json

        expect(response.status).to eq 403
      end
    end

    context 'logged in as a user manager' do
      it 'returns users collection' do
        authorize_with user_manager.auth_token

        get :index, format: :json

        expect(response.status).to eq 200
        expect(response).to render_template('api/v1/admin/users/index')
      end
    end
  end

  describe '#update' do
    context 'logged in as a regular user' do
      it 'returns 403 error' do
        authorize_with regular_user.auth_token

        patch :update,
          { id: 123,
            user: { preferred_working_hour: 4 },
            format: :json }

        expect(response.status).to eq 403
      end
    end

    context 'logged in as a user manager' do
      it 'returns users collection' do
        authorize_with user_manager.auth_token

        patch :update,
          { id: regular_user.id,
            user: { preferred_working_hour: 4 },
            format: :json }

        expect(response.status).to eq 200
        expect(response.body).to eq(
          { notice: Api::V1::Admin::UsersController::MSG[:update] }.to_json)
      end
    end
  end
end
