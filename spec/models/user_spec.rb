require 'spec_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryBot.build(:user) }
  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  describe 'when email is not present' do
    before { @user.email = '' }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should validate_confirmation_of(:password) }
    it { should allow_value('example@domain.com').for(:email) }
  end

  it { should respond_to(:auth_token) }
  it { should validate_uniqueness_of(:auth_token) }

  describe '#generate auth token' do
    it 'generate unique auth token' do
      Devise.stub(:friendly_token).and_return('auniquetoken123')
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql 'auniquetoken123'
    end

    it 'generate new token if already auth_token present' do
      existing_user = FactoryBot.create(:user, auth_token: 'auniquetoken123')
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql 'auniquetoken123'
    end
  end
end

