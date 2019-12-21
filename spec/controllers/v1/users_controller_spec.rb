require 'spec_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  before(:each) { request.headers['Accept'] = "application/vnd.marketplace.v1" }

  describe 'Get #show' do
    before(:each) do
      @user = FactoryBot.create :user
      get :show, params: { use_route: 'api/v1/users', id: @user.id}, format: :josn
    end

    it 'returns the information about a reporter on hash' do
      user_response = json_response
      expect(user_response[:email]).to eql @user.email
    end

    it { expect(response).to have_http_status(200) }
  end

  describe '#post create user' do
    context 'when user is created' do
      before(:each) do
        @user_attributes = FactoryBot.attributes_for :user
        post :create, params: { use_route: 'api/v1/users', user: @user_attributes }, format: :json
      end

      it 'render the response of user just created' do
        user_response = json_response
        expect(user_response[:email]).to eql @user_attributes[:email]
      end

      it { expect(response).to have_http_status(201) }
    end

    context 'when user is not created' do
      before(:each) do
        @invalid_user_attribute = { password: '12345678', password_confirmation: '12345678' }
        post :create, params: { use_route: 'api/v1/users', user: @invalid_user_attribute }, format: :json
      end

      it 'render the error message' do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "can't be blank"
      end

      it { expect(response).to have_http_status(422)}
    end
  end

  describe '#put update user' do
    context 'when user is updated' do
      before(:each) do
        @user = FactoryBot.create :user
        api_authorization_header @user[:auth_token]
        put :update, params: { use_route: 'api/v1/users/:id', id: @user.id, user: { email: 'new_email@test.com'} }
      end

      it 'render the response just updated user' do
        user_response = json_response
        expect(user_response[:email]).to eql 'new_email@test.com'
      end
    end

    context 'when user is not created' do
      before(:each) do
        @user = FactoryBot.create :user
        api_authorization_header @user[:auth_token]
        put :update, params: { use_route: 'api/v1/users/:id', user: { email: 'invalidemail.com' } }
      end

      it 'when user is not updated' do
        user_response = json_response
        expect(user_response[:errors][:email]).to include 'is invalid'
      end
    end
  end

  describe '#delete delete user' do
    context 'when user is deleted' do
      before(:each) do
        @user = FactoryBot.create :user
        api_authorization_header @user[:auth_token]
        delete :destroy, params: { use_route: 'api/v1/user/id' }
      end

      it { expect(response).to have_http_status(204)}
    end
  end
end