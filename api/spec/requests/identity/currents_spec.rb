# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Email Verifications', type: :request do
  let(:user) { FactoryBot.create(:user, :not_verified) }

  describe '#show' do
    let!(:sid) { user.generate_token_for(:email_verification) }

    context 'user is logged in' do
      let(:body) { JSON.parse(response.body) }
      before { sign_in_as(user) }

      it 'sends the user info' do
        get identity_current_url

        expect(body.dig('user', 'id')).to eq(user.id)
        expect(response).to have_http_status(:success)
      end
    end

    context 'invalid token' do
      it 'is unauthorized' do
        get identity_current_url

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
