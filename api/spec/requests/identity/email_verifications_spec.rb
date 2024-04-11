# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Email Verifications', type: :request do
  let(:user) { FactoryBot.create(:user, :not_verified) }
  let!(:sid) { user.generate_token_for(:email_verification) }

  describe '#show' do
    context 'valid token' do
      it 'verifies the user' do
        get identity_email_verification_url, params: { sid: }

        expect(user.reload.verified?).to eq(true)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'invalid token' do
      before { travel 3.days }

      it 'does not verify the user' do
        get identity_email_verification_url, params: { sid: }

        expect(user.reload.verified?).to eq(false)
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#create' do
    it 'sends an email' do
      expect do
        post identity_email_verification_url, params: { sid: }
      end.to(
        have_enqueued_job(ActionMailer::MailDeliveryJob)
      )

      expect(response).to have_http_status(:no_content)
    end
  end
end
