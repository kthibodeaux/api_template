# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_context 'stub signed in user' do
  before do
    Current.session = FactoryBot.create(:session, user:)
  end

  after do
    Current.session = nil
  end
end
