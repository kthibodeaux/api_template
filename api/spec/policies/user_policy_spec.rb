# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy do
  subject { described_class }
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  permissions :update? do
    specify do
      expect(subject).to permit(user, user)
      expect(subject).to_not permit(other_user, user)
    end
  end
end
