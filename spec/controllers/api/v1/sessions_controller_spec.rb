require 'rails_helper'

describe Api::V1::SessionsController do
  describe '#create' do
    context 'with valid inputs' do
      it 'logs the user in' do
        user = create :user

        post :create,
          { session: { email: user.email, password: user.password_digest },
            format: :json }

        expect(response.status).to eq 200
        expect(response.body).to eq(
          { notice: Api::V1::SessionsController::MSG[:success] }.to_json)
      end

      it 'returns error message' do
        user = create :user

        post :create,
          { session: { email: '', password: user.password_digest },
            format: :json }

        expect(response.status).to eq 400
        expect(response.body).to eq(
          { notice: Api::V1::SessionsController::MSG[:error] }.to_json)
      end
    end
  end

  describe '#destroy' do
    it 'logs out the user' do
      user = create :user
      delete :destroy

      expect(response.status).to eq 200
      expect(response.body).to eq(
        { notice: Api::V1::SessionsController::MSG[:destroy] }.to_json)
    end
  end
end
