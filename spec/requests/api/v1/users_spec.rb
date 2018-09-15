require 'rails_helper'

RSpec.describe 'Users' do
  let(:users) { FactoryBot.create_list(:user, 10) }
  let(:valid_attributes) { FactoryBot.attributes_for(:user) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:user, phone_number: nil) }

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

  describe 'GET /api/v1/users/:user_id' do
    before(:each) do
      get api_v1_user_path(users.first.id), headers: auth_headers(users.first.id)
    end

    it 'should return the expected user attributes' do
      user_response = json_response[:data]

      expect(user_response[:id]).to eql users.first.id.to_s
      expect(user_response[:attributes]['phone-number'.to_sym]).to eql users.first.phone_number
      expect(user_response[:attributes]['name'.to_sym]).to eql users.first.name
    end

    it { expect(response).to have_http_status(:ok) }

    context 'with unauthenticated user' do
      before(:each) do
        get api_v1_user_path(users.first.id)
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end

  describe 'POST /api/v1/users' do
    context 'with valid attributes' do
      before(:each) do
        post api_v1_users_path,
            headers: auth_headers(users.first.id),
            params: { user: valid_attributes }
      end

      it 'should return the new user params' do
        user_response = json_response[:data][:attributes]
        expect(user_response[:name]).to eql valid_attributes[:name]
        expect(user_response['phone-number']).to eql valid_attributes['phone-number']
      end

      it { expect(response).to have_http_status(:created) }

      context 'with unauthenticated user' do
        before(:each) do
          post api_v1_users_path, params: { user: valid_attributes }
        end

        it { expect(response).to have_http_status(:unauthorized) }
      end
    end

    context 'with invalid attributes' do
      before(:each) do
        post api_v1_users_path,
             headers: auth_headers(users.first.id),
             params: { user: invalid_attributes }
      end

      it 'response contains the correct error message' do
        error_response = json_response[:phone_number]

        expect(error_response).to include "can't be blank"
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'PUT /api/v1/users/:user_id' do
    context 'with valid attributes' do
      before(:each) do
        put api_v1_user_path(users.first.id),
            headers: auth_headers(users.first.id),
            params: { user: valid_attributes }
      end

      it 'should return the updated user params' do
        user_response = json_response[:data][:attributes]
        expect(user_response[:name]).to eql valid_attributes[:name]
        expect(user_response['phone-number']).to eql valid_attributes['phone-number']
      end

      it { expect(response).to have_http_status(:ok) }

      context 'with unauthenticated user' do
        before(:each) do
          put api_v1_user_path(users.first.id), params: { user: valid_attributes }
        end

        it { expect(response).to have_http_status(:unauthorized) }
      end
    end

    context 'with invalid attributes' do
      before(:each) do
        put api_v1_user_path(users.first.id),
            headers: auth_headers(users.first.id),
            params: { user: invalid_attributes }
      end

      it 'response contains the correct error message' do
        error_response = json_response[:phone_number]

        expect(error_response).to include "can't be blank"
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'DELETE /api/v1/users' do
    before(:each) do
      delete api_v1_user_path(users.first.id),
           headers: auth_headers(users.first.id)
    end

    it { expect(response).to have_http_status(:no_content) }

    context 'with unauthenticated user' do
      before(:each) do
        delete api_v1_user_path(users.first.id)
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
