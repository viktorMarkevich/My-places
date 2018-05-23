require 'rails_helper'

describe ConfirmationsController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  let(:user) { create :user, confirmation_token: 'confirmation_token', confirmation_sent_at: Time.now.utc }
  let(:user_2) { create :user, confirmation_token: 'confirmation_token2', confirmation_sent_at: Time.now.utc - 30.days }

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

    it 'when confirmation_sent_at time is expired' do
      post :create, params: { token: { confirmation_token: user_2.confirmation_token } }, as: :json
      user_2.reload
      p (user_2.confirmation_sent_at > Time.now.utc)

      expect(json).to eq('status' => 'Invalid token')
      expect(user_2.confirmation_token.present?).to eq true
      expect(user_2.confirmation_sent_at.present?).to eq false
      expect(user_2.confirmed_at.present?).to eq false
    end
  end
end