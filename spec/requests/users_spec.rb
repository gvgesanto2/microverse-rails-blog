require 'rails_helper'

FAKE_USER_ID ||= '1'
FAKE_USER ||= 'fake user'
FAKE_ALL_USERS ||= 'all users'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    before(:each) do 
      allow(User).to receive(:all) { FAKE_ALL_USERS }
      get '/users' 
    end

    it 'should assign all the users to @users' do
      expect(User).to have_received(:all)
      expect(assigns(:users)).to eq(FAKE_ALL_USERS)
    end

    it 'returns an http success response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      expect(response).to render_template('users/index')
    end

    it 'includes the correct placeholder text' do
      expect(response.body).to include('Here is a list of users')
    end
  end

  describe 'GET /users/:user_id' do
    before(:each) do
      allow(User).to receive(:find) { FAKE_USER }
      get "/users/#{FAKE_USER_ID}"
    end

    it 'should assign the correct user to @user' do
      expect(User).to have_received(:find).with(FAKE_USER_ID)
      expect(assigns(:user)).to eq(FAKE_USER)
    end

    it 'returns an http success response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      expect(response).to render_template('users/show')
    end

    it 'includes the correct placeholder text' do
      expect(response.body).to include('Here is the profile of a specific user')
    end
  end
end