require 'spec_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  before(:each) { request.headers['Accept'] = "application/vnd.marketplace.v1" }

  describe 'Get #show' do
    before(:each) do
      @user = FactoryBot.create :user
      get :show, params: { use_route: 'api/v1/users', id: @user.id}, format: :josn
    end

    it 'returns the information about a reporter on hash' do
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response[:email]).to eql @user.email
    end

    it { expect(response).to have_http_status(200) }
  end
end