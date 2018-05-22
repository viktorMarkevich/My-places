require 'rails_helper'
require 'jwt'

describe AuthenticationController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  
  describe 'sign in' do
    context 'when the user is exist' do
      let(:user) { create :user }

      it 'responds with a auth_token' do
        post 'authenticate', params: { email: user.email,
                                       password: '123456' }, as: :json
        expect(json['auth_token'].length).to eq 105
      end
    end

    context 'when the user is not exist' do
      it 'responds with a auth_token' do
        post 'authenticate', params: { email: 'fake@email.com',
                                       password: '123456' }, as: :json
        expect(json).to eq({ 'error' => { 'user_authentication' => ['invalid credentials'] } })
      end
    end
  end
end