require 'rails_helper'

describe Api::V1::CurrentUsersController do
  let!(:user) { create :user }

  describe '#show' do
    subject { get :show, format: :json }

    context 'without an auth token' do
      it 'returns 401 (Unauthorized)' do
        subject

        expect(response.status).to eq 401
      end
    end

    context 'with an auth token' do
      it 'returns json formatted current user info' do
        authorize_with user.auth_token

        subject

        expect(response.status).to eq 200
        expect(response).to render_template('api/v1/current_users/show')
      end
    end
  end
end
