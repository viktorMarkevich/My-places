require 'spec_helper'
require 'jwt'

describe AuthenticationController, type: :api do

  context 'when the cat does not exist' do

    before do
      let(:user) { build :user }
      # token = JWT.encode({user: User.first.id},
      #                    ENV["AUTH_SECRET"], "HS256")
      # header "Authorization", "Bearer #{token}"
      # get "/cats/-1/hobbies"
    end

    it 'responds with a 404 status' do
      p user
      # expect(last_response.status).to eq 404
    end

    # it 'responds with a message of Not found' do
    #   message = json["errors"].first["detail"]
    #   expect(message).to eq("Not found")
    # end
  end
end