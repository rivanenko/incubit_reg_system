require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe 'welcome' do
    let(:user) { create(:user, name: 'test', email: 'test@example.com') }
    let(:mail) { described_class.welcome(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Welcome to Incubit, test')
      expect(mail.to).to eq(['test@example.com'])
      expect(mail.from).to eq(['support@incubit.co.jp'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include('Welcome test (test@example.com)')
    end
  end
end
