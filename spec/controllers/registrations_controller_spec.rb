require 'rails_helper'
require 'jwt'

describe RegistrationsController, type: :controller do
  let(:json) { JSON.parse(response.body) }

  # context 'when the user is exist' do
  #   let(:user) { create :user }
  #
  #   it 'responds with a auth_token' do
  #     post 'authenticate', params: { email: user.email,
  #                                    password: '123456' }, as: :json
  #     expect(json['auth_token'].length).to eq 105
  #   end
  # end

  context 'when the user is not exist' do
    before :each do
      post :create, params: { user: { email: 'fake@email.com',
                                      password: '123456' }}, as: :json
    end

    it 'responds with a auth_token' do
      expect(json).to eq('status' => 'User created successfully')
      expect(User.count).to eq 1
      expect(User.last.confirmation_token.present?).to eq true
      expect(User.last.confirmation_sent_at.present?).to eq true
    end

    it 'sends a confirmation email' do
      expect{ User.last.deliver_confirmation }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end