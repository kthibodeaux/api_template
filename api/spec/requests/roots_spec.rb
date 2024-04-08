# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Root', type: :request do
  describe '#index' do
    it 'redirects to frontend' do
      get root_url

      expect(response.headers.fetch('location')).to eq(ENV['FRONTEND_URL'])
      expect(response).to have_http_status(:redirect)
    end
  end
end
