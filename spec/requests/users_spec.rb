require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:json) { JSON.parse(response.body) }

  let!(:users) { create_list(:user, 10) }
  let(:headers) { valid_headers }

  describe 'User as user' do
    let(:user) { create :user }

    describe 'GET /admin/users' do
      before { get '/admin/users', params: {}, headers: headers }

      it 'returns users' do
        expect(json).not_to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(403)
      end
    end
  end
  describe 'User as Admin' do
    let(:user) { create :user, role: 'admin' }

    describe 'GET /admin/users' do
      before { get '/admin/users', params: {}, headers: headers }

      it 'returns users' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    describe 'GET /admin/users/:id' do
      context 'when the record exists' do
        before { get "/admin/users/#{user.id}", params: {}, headers: headers  }
        it 'returns the user' do
          expect(json).not_to be_empty
          expect(json['id']).to eq(user.id)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'when the record does not exist' do
        before { get "/admin/users/#{user.id + 1}", params: {}, headers: headers  }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
          match = "Couldn't find User with 'id'=#{user.id + 1}"
          expect(response.body).to match(match)
        end
      end
    end

    describe 'POST /admin/users' do
      context 'when the request is valid' do
        before { post '/admin/users', params: { name: 'name',
                                          email: 'email@example.com', password: '123456',
                                          password_confirmation: '123456' }.to_json, headers: headers }

        it 'creates a user' do
          expect(json['name']).to eq('name')
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when the request is invalid' do
        before { post '/admin/users', params: { email: nil }.to_json, headers: headers }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a validation failure message' do
          expect(response.body)
              .to match(/Validation failed: Password can't be blank, Password can't be blank, Email can't be blank, Name can't be blank, Password confirmation can't be blank/)
        end
      end
    end

    describe 'PUT /admin/users/:id' do
      let(:valid_attributes) { { name: 'Shopping' } }

      context 'when the record exists' do
        before { put "/admin/users/#{user.id}", params: valid_attributes.to_json, headers: headers  }

        it 'updates the record' do
          expect(response.body).to be_empty
        end

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end
    end

    describe 'DELETE /admin/users/:id' do
      before { delete "/admin/users/#{user.id}", params: {}, headers: headers }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
end