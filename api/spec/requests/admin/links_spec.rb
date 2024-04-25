# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Links', type: :request do
  before { sign_in_as(user) }

  describe '#index' do
    context 'user is an admin' do
      let(:user) { FactoryBot.create(:user, :admin) }

      it 'returns links' do
        get admin_links_url

        expect(response).to have_http_status(:success)
        expect(response.parsed_body).to_not be_empty
      end
    end

    context 'user is not an admin' do
      let(:user) { FactoryBot.create(:user) }

      it 'is unauthorized' do
        get admin_links_url

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
