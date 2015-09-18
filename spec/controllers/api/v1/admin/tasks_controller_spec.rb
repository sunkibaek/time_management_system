require 'rails_helper'

describe Api::V1::Admin::TasksController do
  describe '#index' do
    subject { get :index, format: :json }

    context 'with admin logged in' do
      it 'fetches tasks for all users' do
        user = create :user
        admin = create :admin
        authorize_with admin.auth_token

        create :task, user: user

        subject

        expect(response.status).to eq 200
        expect(response).to render_template('api/v1/admin/tasks/index')
      end
    end

    context 'with regular user logged in' do
      it 'gets 403 error' do
        user = create :user

        authorize_with user.auth_token

        subject

        expect(response.status).to eq 403
      end
    end
  end

  describe '#show' do
    let!(:task_of_other_user) { create :task }
    subject { get :show, { id: task_of_other_user.id, format: :json } }

    context 'with admin logged in' do
      it 'fetches task info in json' do
        admin = create :admin

        authorize_with admin.auth_token

        subject

        expect(response.status).to eq 200
        expect(response).to render_template('api/v1/admin/tasks/show')
      end
    end

    context 'with regular user logged in' do
      it 'gets 403 error' do
        user = create :user

        authorize_with user.auth_token

        subject

        expect(response.status).to eq 403
      end
    end
  end

  describe '#update' do
    let!(:task_of_other_user) { create :task }
    subject do
      patch :update,
        { id: task_of_other_user.id,
          task: { description: 'Edited by Admin' },
          format: :json }
    end

    context 'with admin logged in' do
      it 'updates the task' do
        admin = create :admin

        authorize_with admin.auth_token

        subject

        expect(response.status).to eq 200
        expect(response.body).to eq(
          { notice: Api::V1::Admin::TasksController::MSG[:update] }.to_json)
      end
    end

    context 'with regular user logged in' do
      it 'gets 403 error' do
        user = create :user

        authorize_with user.auth_token

        subject

        expect(response.status).to eq 403
      end
    end
  end

  describe '#destroy' do
    let!(:task_of_other_user) { create :task }
    subject { delete :destroy, { id: task_of_other_user.id, format: :json } }

    context 'with admin logged in' do
      it 'deletes the task' do
        admin = create :admin

        authorize_with admin.auth_token

        subject

        expect(response.status).to eq 200
        expect(response.body).to eq(
          { notice: Api::V1::Admin::TasksController::MSG[:destroy] }.to_json)
      end
    end

    context 'with regular user logged in' do
      it 'gets 403 error' do
        user = create :user

        authorize_with user.auth_token

        subject

        expect(response.status).to eq 403
      end
    end
  end
end
