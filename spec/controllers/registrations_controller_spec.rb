require 'rails_helper'
require 'jwt'

describe RegistrationsController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  let(:user) { build :user }

  context 'when the user is not exist' do
    before :each do
      post :create, params: { user: { email: user.email,
                                      first_name: user.first_name,
                                      last_name: user.last_name,
                                      password: user.password,
                                      password_confirmation: user.password_confirmation, }}, as: :json
    end

    it 'responds with a auth_token' do
      expect(json).to eq('status' => 'User created successfully')
      expect(User.count).to eq 1
      expect(User.last.confirmation_token.present?).to eq true
      expect(User.last.confirmation_sent_at.present?).to eq true
    end

    it 'sends a confirmation email' do
      expect{ User.last.set_confirmation }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end