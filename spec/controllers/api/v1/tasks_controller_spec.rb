require 'rails_helper'

describe Api::V1::TasksController do
  describe '#index' do
    subject { get :index, format: :json }

    it 'fetches tasks for current user' do
      user = create :user
      sign_in user

      3.times do
        create :task, user: user
      end
      create :task

      tasks = user.tasks

      subject
      expect(response.status).to eq 200
      expect(response).to render_template('api/v1/tasks/index')
      expect(flash[:notice]).to eq Api::V1::TasksController::MSG[:index]
    end
  end

  describe '#show' do
    it 'fetches the task' do
      user = create :user
      task = create :task, user: user
      sign_in user

      get :show, id: task.id, format: :json

      expect(response.status).to eq 200
      expect(response).to render_template('api/v1/tasks/show')
    end
  end

  describe '#create' do
    subject do
      post :create,
        { task:
          { description: 'Test task description',
            date: '31/12/2014',
            hour: 4 },
          format: :json }
    end

    it 'creates a task' do
      user = create :user
      sign_in user

      expect{ subject }.to change{ user.tasks.size }.by 1
      expect(response.status).to eq 200
      expect(response.body).to eq(
        { notice: Api::V1::TasksController::MSG[:success] }.to_json)
    end
  end

end