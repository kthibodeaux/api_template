# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Passwords', type: :request do
  let(:user) { FactoryBot.create(:user) }

  before { sign_in_as(user) }

  describe '#update' do
    let(:new_password) { 'Secret6*4*2*' }

    context 'password challenge is correct' do
      it 'updates the password' do
        patch identity_password_url, params: {
          password_challenge: user.password,
          password: new_password,
          password_confirmation: new_password
        }

        expect(response).to have_http_status(:ok)
      end
    end

    context 'password challenge is incorrect' do
      it 'does not update the password' do
        patch identity_password_url, params: {
          password_challenge: "#{user.password}x",
          password: new_password,
          password_confirmation: new_password
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
