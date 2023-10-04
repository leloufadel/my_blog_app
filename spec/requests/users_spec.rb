require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'Must render a successful response' do
      get users_path
      expect(response).to have_http_status(:success)
    end
    it 'Must return a 200 OK status' do
      get '/users'
      expect(response).to have_http_status(200)
    end
    it 'Must render the index template' do
      get users_path
      expect(response).to render_template(:index)
    end
    it 'Must have a correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('List of Users')
    end
  end
  describe 'GET /users/456' do
    it 'Must render a successful response' do
      get users_path(456)
      expect(response).to have_http_status(:success)
    end

    it 'Must return a 200 OK status' do
      get '/users/456'
      expect(response).to have_http_status(200)
    end

    it 'Must render the index template' do
      get '/users/456'
      expect(response).to render_template(:show)
    end

    it 'Must have a correct placeholder text in the response body' do
      get '/users/456'
      expect(response.body).to include('Here is a list of users for your Blog app')
    end
  end
end
