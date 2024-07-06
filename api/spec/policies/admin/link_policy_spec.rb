# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::LinkPolicy do
  subject { described_class }
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }

  permissions :index? do
    specify do
      expect(subject).to permit(admin)
      expect(subject).to_not permit(user)
    end
  end
end
