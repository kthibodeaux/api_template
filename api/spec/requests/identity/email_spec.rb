# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Updating email address', type: :request do
  describe '#create' do
    let(:user) { create(:user) }
    let(:new_email) { Faker::Internet.email }

    before { sign_in_as(user) }

    it 'sends an email' do
      expect do
        post identity_email_url, params: { email_change_to: new_email }
      end.to(
        have_enqueued_job(ActionMailer::MailDeliveryJob)
      )

      expect(response).to have_http_status(:no_content)
    end

    it 'updates User#email_change_to' do
      post identity_email_url, params: {
        email_change_to: new_email
      }

      expect(user.reload.email_change_to).to eq(new_email)
      expect(response).to have_http_status(:success)
    end
  end

  describe '#update' do
    let!(:sid) { user.generate_token_for(:change_email) }
    let(:user) { create(:user, email_change_to: new_email) }
    let(:new_email) { Faker::Internet.email }

    it 'updates User#email' do
      patch identity_email_url, params: {
        sid:
      }

      user.reload

      expect(user.email).to eq(new_email)
      expect(user.email_change_to).to eq(nil)
      expect(response).to have_http_status(:success)
    end
  end
end
