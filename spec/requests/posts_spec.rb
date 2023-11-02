require 'rails_helper'

require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET #index' do
    before { get user_posts_path(user_id: 1) }

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      expect(response.body).to include('Here is a list of posts for given user')
    end
  end

  describe 'GET #show' do
    before { get user_post_path(user_id: 1, id: 1) }

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      expect(response.body).to include('Here is the details of post')
    end
  end
end
