# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Health Checks', type: :request do
  describe '#show' do
    it 'returns 200' do
      get(health_check_url)

      expect(response).to have_http_status(200)
    end

    it 'contains a header for server version' do
      get(health_check_url)

      expect(response.headers['api-server-version']).to_not be_empty
    end
  end
end
