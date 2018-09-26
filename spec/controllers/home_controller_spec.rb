require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe 'GET #index' do
    let(:json) { JSON.parse(response.body) }

    let(:user) { create :user }
    let(:headers) { valid_headers }

    before {
      request.headers.merge!(headers)
    }

    it 'returns http success' do
      get :index, as: :json

      expect(response).to have_http_status(:success)
      expect(json['data']).to eq 'Hello World!'
    end
  end
end
