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

      context 'when user is confirmed' do
        let(:user) { create :confirmed_user }
        before do
          user.update_attributes(confirmation_token: nil, confirmed_at: Time.now.utc) # strange!
        end
        it 'should return empty "auth_token"' do
          post 'authenticate', params: { login: { email: user.email,
                                         password: '123456' } }, as: :json
          user.reload
          expect(json['auth_token'].present?).to eq true
        end
      end
    end

    context 'when the user is not exist' do
      it 'responds with a auth_token' do
        post 'authenticate', params: { login: { email: 'fake@email.com',
                                       password: '123456' } }, as: :json
        expect(json).to eq("error" => {"user_authentication"=>["invalid credentials"]})
      end
    end
  end
end