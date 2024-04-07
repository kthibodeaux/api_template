# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe '#index' do
    include_context 'user is signed in'

    it 'gets all sessions' do
      get sessions_url, headers: default_headers

      expect(response).to have_http_status(:success)
    end
  end

  describe '#show' do
    include_context 'user is signed in'

    it 'gets current session' do
      get session_url(user.sessions.last), headers: default_headers

      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    context 'credentials are correct' do
      let(:user) { FactoryBot.create(:user) }
      let(:params) { { email: user.email, password: 'Secret1*3*5*' } }

      it 'signs in' do
        post(sign_in_url, params:)

        expect(response).to have_http_status(:created)
      end
    end

    context 'credentials are incorrect' do
      let(:user) { FactoryBot.create(:user) }
      let(:params) { { email: user.email, password: 'Secret1*3' } }

      it 'signs in' do
        post(sign_in_url, params:)

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe '#destroy' do
    include_context 'user is signed in'

    it 'signs out' do
      delete session_url(user.sessions.last), headers: default_headers

      expect(response).to have_http_status(:no_content)
    end
  end
end
