# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }

  describe '#password_reset' do
    let(:mail) { described_class.with(user:).password_reset }

    it 'renders the subject' do
      expect(mail.subject).to eq('Reset your password')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end
  end

  describe '#email_verification' do
    let(:mail) { described_class.with(user:).email_verification }

    it 'renders the subject' do
      expect(mail.subject).to eq('Verify your email')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end
  end
end
