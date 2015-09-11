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
        expect{ subject }.to change(User, :count).by 1
        expect(flash[:notice]).to eq Api::V1::UsersController::MSG[:success]
        expect(response).to render_template('api/v1/users/create')
      end
    end

    context 'with invalid input' do
      subject do
        post :create,
          { user: { name: '', email: '', password: '' },
            format: :json }
      end

      it 'returns an error message' do
        expect{ subject }.to change(User, :count).by 0
        expect(response.body).to eq(
          { notice: Api::V1::UsersController::MSG[:error] }.to_json)
      end
    end
  end
end
