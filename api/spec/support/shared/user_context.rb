# frozen_string_literal: true

RSpec.shared_context 'user is signed in' do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { sign_in_as user }

  let!(:default_headers) do
    { 'Authorization' => "Bearer #{token}" }
  end
end
