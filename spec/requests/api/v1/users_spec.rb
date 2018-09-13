require 'rails_helper'

RSpec.describe 'Users' do
  let(:users) { FactoryBot.create_list(:user, 10) }

  describe 'GET /api/v1/users' do
    before(:each) do
      get api_v1_users_path, headers: auth_headers(users.first.id)
    end

    it 'should return list of existing users' do
      users_response = json_response[:data]
      expect(users_response.size).to eql users.size
    end

    it { expect(response).to have_http_status(:ok) }

    context 'with unauthenticated user' do
      before(:each) do
        get api_v1_users_path
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
