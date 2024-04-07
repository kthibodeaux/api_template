# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Emails', type: :request do
  include_context 'user is signed in'

  describe '#update' do
    let(:new_email) { Faker::Internet.email }

    context 'password challenge is correct' do
      it 'updates the email' do
        patch identity_email_url, params: {
          email: new_email,
          password_challenge: 'Secret1*3*5*'
        }, headers: default_headers

        expect(response).to have_http_status(:success)
      end
    end

    context 'password challenge is incorrect' do
      it 'updates the email' do
        patch identity_email_url, params: {
          email: new_email,
          password_challenge: 'Secret1*3'
        }, headers: default_headers

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
