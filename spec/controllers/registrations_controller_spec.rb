require 'rails_helper'
require 'jwt'

describe RegistrationsController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  let(:user) { build :user }

  describe 'User as User role' do
    context 'when the user is not exist' do
      before :each do
        post :create, params: attributes_for(:user).merge!(role: 'admin'), as: :json
      end

      it 'responds with a auth_token' do
        expect(json['message']).to eq('Account created successfully')
        expect(json['auth_token'].present?).to eq true
        expect(User.count).to eq 1
        expect(User.last.role).to eq 'admin'
      end
    end
  end

  describe 'User as Admin role' do
    context 'when the user is not exist' do
      before :each do
        post :create, params: attributes_for(:user), as: :json
      end

      it 'responds with a auth_token' do
        expect(json['message']).to eq('Account created successfully')
        expect(json['auth_token'].present?).to eq true
        expect(User.count).to eq 1
        expect(User.last.role).to eq 'user'
      end
    end
  end
end