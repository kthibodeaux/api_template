# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Identity Attributes', type: :request do
  let(:user) { FactoryBot.create(:user) }

  before { sign_in_as(user) }

  describe '#update' do
    context 'updating email' do
      let(:new_email) { Faker::Internet.email }

      it 'updates the email' do
        patch identity_attributes_url, params: {
          email: new_email
        }

        expect(user.reload.email).to eq(new_email)
        expect(response).to have_http_status(:success)
      end
    end

    context 'updating password' do
      let(:new_password) { 'Secret6*4*2*' }

      it 'updates the password' do
        patch identity_attributes_url, params: {
          password: new_password,
          password_confirmation: new_password
        }

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
