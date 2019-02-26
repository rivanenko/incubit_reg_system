require 'rails_helper'

RSpec.describe User, type: :model do
  let(:email) { 'test@example.com' }
  let(:password) { '12345678' }
  subject { described_class.new(email: email, password: password, password_confirmation: password) }

  describe '.validations' do
    context 'for password' do
      it { should validate_length_of(:password).is_at_least(8) }
      it { should validate_confirmation_of(:password) }
    end

    context 'for email' do
      it { should validate_presence_of(:email) }
    end

    context 'for name' do
      it { should validate_length_of(:name).is_at_least(5).on(:update) }

      it { should_not validate_length_of(:name).is_at_least(5).on(:create) }
    end
  end

  describe '.callbacks' do
    before { subject.save }

    it 'extracts name from email' do
      expect(subject.name).to eq('test')
    end

    it 'generates token' do
      expect(subject.token).to_not be_nil
    end
  end

  describe '#token_reset' do
    before { subject.token_reset}

    it 'sets reset fields & saves the object' do
      expect(subject.reset_token).to_not be_nil
      expect(subject.reset_token_sent_at).to_not be_nil
      expect(subject.persisted?).to be_truthy
    end
  end
end
