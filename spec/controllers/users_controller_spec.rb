require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:params) do
    {
      user: {
        name: 'test',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
    }
  end

  it { should route(:get, '/signup').to(action: :new) }

  describe '.permit' do
    context 'on create' do
      it do
        should permit(:email, :password, :password_confirmation).
          for(:create, params: params).on(:user)
      end
    end

    context 'on update' do
      let!(:user) { create(:user) }
      let(:params) { super().merge(id: user.id) }

      before { request.cookies[:auth_token] = user.token }

      it do
        should permit(:name, :password, :password_confirmation).
          for(:update, params: params).on(:user)
      end
    end
  end

  describe '.callbacks' do
    it { should use_before_action(:find_user) }
    it { should use_before_action(:must_login) }
  end

  describe 'POST #create' do
    subject { post(:create, params)  }

    it 'sends welcome email' do
      expect(UserMailer).to receive_message_chain(:welcome, :deliver)
      subject
    end

    it 'sets the user and redirects to login page' do
      subject

      expect(response).to redirect_to('/login')
      expect(controller.current_user).to_not be_nil
    end

    it 'creates user' do
      expect { subject }.to change(User, :count).by(1)
    end
  end
end
