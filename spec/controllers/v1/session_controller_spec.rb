require 'spec_helper'

RSpec.describe Api::V1::SessionController, type: :controller do
  describe 'Post #create user session' do
    before(:each) do
      @user = FactoryBot.create(:user)
    end

    context 'when credential are correct' do
      before(:each) do
        credential = { email: @user.email, password: @user.password  }
        post :create, params: { use_route: 'api/v1/session', session: credential }
      end

      it 'should return user record with corresponding user credential' do
        @user.reload
        expect(json_response[:auth_token]).to eql @user.auth_token
      end
      it { expect(response).to have_http_status(200) }
    end

    context 'when credential are not correct' do
      before(:each) do
        credential = { email: @user.email, password: 'invalidpassword' }
        post :create, params: { use_route: 'api/v1/sign_in', session: credential }
      end
      it 'should return error' do
        expect(json_response[:errors]).to eql "Invalid email or password"
      end

      it { expect(response).to have_http_status(422) }
    end
  end
end
