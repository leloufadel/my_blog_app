require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/3/posts' do
    it 'Must render a successful response' do
      get user_posts_path(3)
      expect(response).to have_http_status(:success)
    end

    it 'Must return a 200 OK status' do
      get '/users/3/posts'
      expect(response).to have_http_status(200)
    end

    it 'Must render the index template' do
      get user_posts_path(3)
      expect(response).to render_template(:index)
    end

    it 'Must have a correct placeholder text in the response body' do
      get user_posts_path(3)
      expect(response.body).to include('Details of posts for a given user')
    end
  end

  describe 'GET /users/10/posts/2' do
    it 'Must render a successful response' do
      get user_posts_path(10, 2)
      expect(response).to have_http_status(:success)
    end

    it 'Must return a 200 OK status' do
      get '/users/10/posts/2'
      expect(response).to have_http_status(200)
    end

    it 'Must render the index template' do
      get '/users/10/posts/2'
      expect(response).to render_template(:show)
    end

    it 'Must have a correct placeholder text in the response body' do
      get '/users/10/posts/2'
      expect(response.body).to include('Here you will find a list of posts for a given user')
    end
  end
end
