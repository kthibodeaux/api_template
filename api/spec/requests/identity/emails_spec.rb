# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Emails', type: :request do
  let(:user) { FactoryBot.create(:user) }

  before { sign_in_as(user) }

  describe '#update' do
    let(:new_email) { Faker::Internet.email }

    context 'password challenge is correct' do
      it 'updates the email' do
        patch identity_email_url, params: {
          email: new_email,
          password_challenge: user.password
        }

        expect(response).to have_http_status(:success)
      end
    end

    context 'password challenge is incorrect' do
      it 'updates the email' do
        patch identity_email_url, params: {
          email: new_email,
          password_challenge: "#{user.password}x"
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
