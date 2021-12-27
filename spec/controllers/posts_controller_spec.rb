require 'rails_helper'

# Change this PostsController to your project
RSpec.describe Api::V1::PostsController, type: :controller do
  describe 'GET #index' do
    let!(:post) { create(:post) }

    it 'returns a success response' do
      get :index, params: {}

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    let!(:post) { create(:post) }

    it 'returns a success response' do
      get :show, params: {
        id: post.id
      }

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it 'returns a not found error response' do
      get :show, params: {
        id: 'UNKNOWN'
      }

      body = JSON.parse(response.body)

      expect(response).to have_http_status(404)
      expect(body['code']).to eq(404)
      expect(body['error']).to eq('Record Not Found')
    end
  end

  describe 'POST #post' do
    let(:post_attributes) { attributes_for(:post) }

    it 'returns a success response' do
      expect(Post.count).to eq(0)

      post :create, params: post_attributes

      expect(response.status).to eq(201)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      json = JSON.parse(response.body)

      expect(json).to have_key('id')
      expect(json).to have_key('created_at')
      expect(json).to have_key('updated_at')

      expect(json[:body]).to eq(post_attributes['body'])
      expect(json[:title]).to eq(post_attributes['title'])
      expect(json[:published_at]).to eq(post_attributes['published_at'])

      expect(Post.count).to eq(1)
    end
  end

  describe 'PUT #post' do
    let!(:post) { create(:post) }

    it 'returns a success response' do
      expect(Post.count).to eq(1)

      put :update, params: {
        id: post.id,
        title: 'TITLE UPDATE',
        body: 'BODY UPDATE',
        published_at: DateTime.now
      }

      expect(response.status).to eq(200)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      json = JSON.parse(response.body)

      expect(json).to have_key('id')
      expect(json).to have_key('created_at')
      expect(json).to have_key('updated_at')

      expect(json['title']).to eq('TITLE UPDATE')
      expect(json['body']).to eq('BODY UPDATE')
      expect(json['published_at']).to eq(post['published_at'])

      expect(Post.count).to eq(1)
    end

    it 'returns a not found error response' do
      put :update, params: {
        id: 'UNKNOWN',
        title: 'TITLE UPDATE',
        body: 'BODY UPDATE',
        published_at: DateTime.now
      }

      body = JSON.parse(response.body)

      expect(response).to have_http_status(404)
      expect(body['code']).to eq(404)
      expect(body['error']).to eq('Record Not Found')
    end
  end

  describe 'DELETE #post' do
    let!(:post) { create(:post) }

    it 'returns a success response' do
      expect(Post.count).to eq(1)

      delete :destroy, params: {
        id: post.id
      }

      expect(response.status).to eq(204)

      expect(Post.count).to eq(0)
    end

    it 'returns a not found error response' do
      delete :destroy, params: {
        id: 'UNKNOWN'
      }

      body = JSON.parse(response.body)

      expect(response).to have_http_status(404)
      expect(body['code']).to eq(404)
      expect(body['error']).to eq('Record Not Found')
    end
  end
end
