require 'rails_helper'

describe Api::V1::UsersController do
  describe '#create' do
    context 'with valid input' do
      subject do
        post :create,
          { user: { name: 'Test User',
            email: 'test@example.com', password: 'testPassword' },
            format: :json }
      end

      it 'creates an user account' do
        expect{ subject }.to change{ User.count }.by 1

        expect(response.status).to eq 200
        expect(JSON.parse(response.body).include?('auth_token')).to eq true
      end
    end

    context 'with invalid input' do
      subject do
        post :create,
          { user: { name: '', email: '', password: '' },
            format: :json }
      end

      it 'returns an error message' do
        expect{ subject }.to change{ User.count }.by 0
        expect(response.body).to eq(
          { notice: Api::V1::UsersController::MSG[:error] }.to_json)
        expect(response.status).to eq 400 # bad request
      end
    end
  end

  describe '#update' do
    context 'with valid input' do
      it 'updates preferred working hour with success notice' do
        user = create :user
        authorize_with user.auth_token

        patch :update,
          { id: 0, user: { preferred_working_hour: 4 }, format: :json }

        expect(response.status).to eq 200
        expect(response.body).to eq(
          { notice: Api::V1::UsersController::MSG[:update] }.to_json)
      end
    end
  end
end
