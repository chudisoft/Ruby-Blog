require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe 'GET /users/:user_id/posts' do
    let(:user) { create(:user) }
    let!(:posts) { create_list(:post, 3, author: user) }

    it 'returns a successful response' do
      get user_posts_path(user)
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get user_posts_path(user)
      expect(response.body).to include('Here is a list of posts by the user')
    end

    it 'lists all posts by the user' do
      get user_posts_path(user)
      posts.each do |post|
        expect(response.body).to include(post.title)
      end
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    let(:user) { create(:user) }
    let(:post) { create(:post, author: user) }

    it 'returns a successful response' do
      get user_post_path(user, post)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get user_post_path(user, post)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get user_post_path(user, post)
      expect(response.body).to include("Details of the post '#{post.title}'")
    end
  end

  describe 'POST /users/:user_id/posts' do
    let(:user) { create(:user) }
    let(:post_params) { { title: 'New Post', text: 'Sample text' } }

    it 'creates a new post for the user' do
      post user_posts_path(user), params: { post: post_params }
      expect(response).to have_http_status(302) # Redirect after creation
      expect(user.posts.last.title).to eq('New Post')
    end
  end

  describe 'GET /users/:user_id/posts/:id/edit' do
    let(:user) { create(:user) }
    let(:post) { create(:post, author: user) }

    it 'returns a successful response' do
      get edit_user_post_path(user, post)
      expect(response).to have_http_status(200)
    end

    it 'renders the edit template' do
      get edit_user_post_path(user, post)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH /users/:user_id/posts/:id' do
    let(:user) { create(:user) }
    let(:post) { create(:post, author: user) }
    let(:updated_attributes) { { title: 'Updated Post', text: 'Updated text' } }

    it 'updates the post' do
      patch user_post_path(user, post), params: { post: updated_attributes }
      expect(response).to have_http_status(302) # Redirect after update
      post.reload
      expect(post.title).to eq('Updated Post')
      expect(post.text).to eq('Updated text')
    end
  end
end
