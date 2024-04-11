# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe '#index' do
    before { sign_in_as(user) }

    it 'gets all sessions' do
      get sessions_url

      expect(response).to have_http_status(:success)
    end
  end

  describe '#show' do
    before { sign_in_as(user) }

    context 'session is not expired' do
      it 'gets current session' do
        get session_url(user.sessions.last)

        expect(response).to have_http_status(:success)
      end
    end

    context 'session is expired' do
      it 'gets current session' do
        travel 13.months

        get session_url(user.sessions.last)

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'session no longer exists' do
      it 'gets current session' do
        session = user.sessions.last
        user.sessions.destroy_all

        get session_url(session)

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe '#create' do
    context 'credentials are correct' do
      let(:params) do
        {
          session: { email: user.email, password: user.password, remember_me: false }
        }
      end

      context 'user is verified' do
        it 'signs in' do
          post(sign_in_url, params:)

          expect(response).to have_http_status(:created)
        end
      end

      context 'user is not verified' do
        let(:user) { FactoryBot.create(:user, :not_verified) }

        it 'signs in' do
          post(sign_in_url, params:)

          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    context 'credentials are incorrect' do
      let(:params) do
        {
          session: { email: user.email, password: "#{user.password}x", remember_me: false }
        }
      end

      it 'signs in' do
        post(sign_in_url, params:)

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe '#destroy' do
    before { sign_in_as(user) }

    it 'signs out' do
      delete session_url(user.sessions.last)

      expect(response).to have_http_status(:no_content)
    end
  end
end
