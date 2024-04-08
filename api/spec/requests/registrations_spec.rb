# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe '#create' do
    let(:email) { FactoryBot.build(:user).email }
    let(:password) { 'Secret1*3*5*' }
    let(:password_confirmation) { password }
    let(:params) do
      { email:, password:, password_confirmation: }
    end

    context 'passwords match' do
      it 'creates a user' do
        post(sign_up_url, params:)

        expect(response).to have_http_status(:created)
      end
    end

    context 'passwords do not match' do
      let(:password_confirmation) { 'Secret*1*3' }

      it 'does not create a user' do
        post(sign_up_url, params:)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'no passwords provided' do
      let(:password) { '' }
      let(:password_confirmation) { '' }

      it 'does not create a user' do
        post(sign_up_url, params:)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'no email provided' do
      let(:email) { '' }

      it 'does not create a user' do
        post(sign_up_url, params:)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
