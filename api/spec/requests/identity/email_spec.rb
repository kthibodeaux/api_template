# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Updating email address', type: :request do
  let(:user) { FactoryBot.create(:user) }

  before { sign_in_as(user) }

  describe '#update' do
    let(:new_email) { Faker::Internet.email }

    it 'updates the email' do
      patch identity_email_url, params: {
        email: new_email
      }

      expect(user.reload.email).to eq(new_email)
      expect(response).to have_http_status(:success)
    end
  end
end
