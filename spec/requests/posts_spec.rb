require 'rails_helper'

FAKE_USER_ID ||= '1'
FAKE_POST_ID ||= '2'
FAKE_POST ||= 'fake post'
FAKE_ALL_USER_POSTS ||= 'all user posts'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/:user_id/posts' do
    before(:each) do 
      allow(Post).to receive(:by_author) { FAKE_ALL_USER_POSTS }
      get "/users/#{FAKE_USER_ID}/posts"
    end

    it 'should assign all the user posts to @posts' do
      expect(Post).to have_received(:by_author).with(FAKE_USER_ID)
      expect(assigns(:posts)).to eq(FAKE_ALL_USER_POSTS)
    end

    it 'returns an http success response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      expect(response).to render_template('posts/index')
    end

    it 'includes the correct placeholder text' do
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end

  describe 'GET /users/:user_id/posts/:post_id' do
    before(:each) do
      allow(Post).to receive(:find) { FAKE_POST }
      get "/users/#{FAKE_USER_ID}/posts/#{FAKE_POST_ID}"
    end

    it 'should assign the correct user post to @post' do
      expect(Post).to have_received(:find).with(FAKE_POST_ID)
      expect(assigns(:post)).to eq(FAKE_POST)
    end

    it 'returns an http success response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      expect(response).to render_template('posts/show')
    end

    it 'includes the correct placeholder text' do
      expect(response.body).to include('Here is a single post of a given user')
    end
  end
end