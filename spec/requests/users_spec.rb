require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'returns a successful response' do
      get '/users'
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get '/users'
      expect(response.body).to include('Here is a list of users')
    end
  end

  describe 'GET /users/:id' do
    let(:user) { create(:user) }

    it 'returns a successful response' do
      get user_path(user)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get user_path(user)
      expect(response.body).to include("Details of user #{user.name}")
    end
  end

  describe 'GET /users/:id/edit' do
    let(:user) { create(:user) }

    it 'returns a successful response' do
      get edit_user_path(user)
      expect(response).to have_http_status(200)
    end

    it 'renders the edit template' do
      get edit_user_path(user)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH /users/:id' do
    let(:user) { create(:user) }
    let(:updated_attributes) { { name: 'Updated User', bio: 'Updated bio' } }

    it 'updates the user' do
      patch user_path(user), params: { user: updated_attributes }
      expect(response).to have_http_status(302) # Redirect after update
      user.reload
      expect(user.name).to eq('Updated User')
      expect(user.bio).to eq('Updated bio')
    end
  end
end
