# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Updating password', type: :request do
  let(:user) { create(:user) }

  before { sign_in_as(user) }

  describe '#update' do
    let(:new_password) { 'Secret6*4*2*' }

    it 'updates the password' do
      patch identity_password_url, params: {
        password: new_password,
        password_confirmation: new_password
      }

      expect(response).to have_http_status(:ok)
    end
  end
end
