require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do

  describe 'GET #index' do
    let(:json) { JSON.parse(response.body) }

    let(:user) { create :confirmed_user }
    let(:user2) { create :confirmed_user }
    let(:headers) { valid_headers }

    let(:user_trips) { create_list :trip, 3, user_id: user.id }
    let(:user2_trips) { create_list :trip, 3, user_id: user2.id }

    before {
      user_trips.each{ |t| t.reload }
      user2_trips.each{ |t| t.reload }

      request.headers.merge!(headers)
    }

    it 'returns http success' do
      get :index, as: :json

      expect(response).to have_http_status(:success)
      expect(json.length).to eq 3
      expect(json.map{ |item| item['id'] }.sort).to eq user_trips.map{ |item| item.id }.sort
    end
  end
end
