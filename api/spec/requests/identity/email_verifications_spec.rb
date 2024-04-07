# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Email Verifications', type: :request do
  include_context 'user is signed in'

  before do
    user.update!(verified: false)
  end

  describe '#show' do
    let!(:sid) { user.generate_token_for(:email_verification) }

    context 'valid token' do
      it 'verifies the user' do
        get identity_email_verification_url, params: { sid: }, headers: default_headers

        expect(user.reload.verified?).to eq(true)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'invalid token' do
      before { travel 3.days }

      it 'does not verify the user' do
        get identity_email_verification_url, params: { sid: }, headers: default_headers

        expect(user.reload.verified?).to eq(false)
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#create' do
    it 'sends an email' do
      expect do
        post identity_email_verification_url, headers: default_headers
      end.to(
        have_enqueued_job(ActionMailer::MailDeliveryJob)
      )

      expect(response).to have_http_status(:no_content)
    end
  end
end
