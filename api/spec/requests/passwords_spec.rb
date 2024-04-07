# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Passwords', type: :request do
  include_context 'user is signed in'

  describe '#update' do
    context 'password challenge is correct' do
      it 'updates the password' do
        patch password_url, params: {
          password_challenge: 'Secret1*3*5*',
          password: 'Secret6*4*2*',
          password_confirmation: 'Secret6*4*2*'
        }, headers: default_headers

        expect(response).to have_http_status(:ok)
      end
    end

    context 'password challenge is incorrect' do
      it 'does not update the password' do
        patch password_url, params: {
          password_challenge: 'Secret1*3',
          password: 'Secret6*4*2*',
          password_confirmation: 'Secret6*4*2*'
        }, headers: default_headers

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
