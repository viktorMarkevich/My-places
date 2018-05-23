require 'rails_helper'

describe ConfirmationsController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  let(:user) { create :user, confirmation_token: 'confirmation_token', confirmation_sent_at: Time.now.utc }

  context 'check token' do
    it 'when token is right' do
      post :create, params: { token: { confirmation_token: user.confirmation_token } }, as: :json
      user.reload

      expect(json).to eq('status' => 'User confirmed successfully')
      expect(user.confirmation_token.present?).to eq false
      expect(user.confirmation_sent_at.present?).to eq true
      expect(user.confirmed_at.present?).to eq true
    end

    it 'when token is wrong' do
      post :create, params: { token: { confirmation_token: 'wrong_token' } }, as: :json
      user.reload

      expect(json).to eq('status' => 'Invalid token')
      expect(user.confirmation_token.present?).to eq true
      expect(user.confirmation_sent_at.present?).to eq true
      expect(user.confirmed_at.present?).to eq false
    end

    it 'when token is empty' do
      post :create, params: { token: nil }, as: :json
      user.reload

      expect(json).to eq('status' => 'Invalid token')
      expect(user.confirmation_token.present?).to eq true
      expect(user.confirmation_sent_at.present?).to eq true
      expect(user.confirmed_at.present?).to eq false
    end
  end
end