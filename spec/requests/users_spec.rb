require 'rails_helper'

FAKE_USER_ID ||= '1'.freeze

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    before(:each) do
      @fake_user = User.new(name: 'Mr.Test', photo: 'testing.png', bio: 'Testing.')
      allow(User).to receive(:all) { [@fake_user] }
      get '/users'
    end

    it 'should assign all the users to @users' do
      expect(User).to have_received(:all)
      expect(assigns(:users)).to eq([@fake_user])
    end

    it 'returns an http success response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      expect(response).to render_template('users/index')
    end
  end

  describe 'GET /users/:user_id' do
    before(:each) do
      @fake_user = User.new(name: 'Mr.Test', photo: 'testing.png', bio: 'Testing.')
      allow(User).to receive(:find) { @fake_user }
      get "/users/#{FAKE_USER_ID}"
    end

    it 'should assign the correct user to @user' do
      expect(User).to have_received(:find).with(FAKE_USER_ID)
      expect(assigns(:user)).to eq(@fake_user)
    end

    it 'returns an http success response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      expect(response).to render_template('users/show')
    end
  end
end
