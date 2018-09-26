require 'rails_helper'
require 'jwt'

describe AuthenticationController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  
  describe 'sign in' do
    context 'when the user is exist' do
      context 'when user is not confirmed' do
        let(:user) { create :user }

        it 'should return empty "auth_token"' do
          post 'authenticate', params: { login: { email: user.email,
                                         password: '123456' } }, as: :json
          expect(json['auth_token'].present?).to eq false
        end
      end
    end

    context 'when the user is not exist' do
      it 'responds with a auth_token' do
        post 'authenticate', params: { login: { email: 'fake@email.com',
                                       password: '123456' } }, as: :json
        expect(json).to eq('message' => 'Invalid credentials')
      end
    end
  end
end