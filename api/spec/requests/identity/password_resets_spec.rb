# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Password Resets', type: :request do
  let(:user) { create(:user) }

  describe '#create' do
    context 'email is verified' do
      let(:email) { user.email }

      context 'user is active' do
        it 'sends a password reset email' do
          expect do
            post identity_password_reset_url, params: { email: }
          end.to(
            have_enqueued_job(ActionMailer::MailDeliveryJob)
          )

          expect(response).to have_http_status(:no_content)
        end
      end

      context 'user is not active' do
        before do
          user.deactivate!
        end

        it 'does not send a password reset email' do
          expect do
            post identity_password_reset_url, params: { email: }
          end.to_not(
            have_enqueued_job(ActionMailer::MailDeliveryJob)
          )

          expect(response).to have_http_status(:no_content)
        end
      end
    end

    context 'email is not verified' do
      let(:user) { create(:user, :not_verified) }
      let(:email) { user.email }

      it 'does not send a password reset email' do
        expect do
          post identity_password_reset_url, params: { email: }
        end.to_not(
          have_enqueued_job(ActionMailer::MailDeliveryJob)
        )

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'email does not exist' do
      let(:email) { "x#{user.email}" }

      it 'does not send a password reset email' do
        expect do
          post identity_password_reset_url, params: { email: }
        end.to_not(
          have_enqueued_job(ActionMailer::MailDeliveryJob)
        )

        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe '#update' do
    let!(:sid) { user.generate_token_for(:password_reset) }

    context 'valid token' do
      it 'updates the password' do
        patch identity_password_reset_url, params: {
          sid:,
          password: 'Secret1*3*5*',
          password_confirmation: 'Secret1*3*5*'
        }

        expect(response).to have_http_status(:success)
      end
    end

    context 'invalid token' do
      let(:email) { Faker::Internet.email }

      it 'does not update the password' do
        patch identity_password_reset_url, params: {
          sid: "x#{sid}",
          password: 'Secret1*3*5*',
          password_confirmation: 'Secret1*3*5*'
        }

        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
